import 'package:remotely/core/utils/assets_manager/assets_manager.dart';
import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/routes_manager/routes_manager.dart';
import 'package:remotely/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/utils/style_manager/style_manager.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../home/data/models/requests/get_service_from_service_id.dart';
import '../../../home/data/models/responses/get_registered_services_and_packages_response.dart';
import '../../../home/presentation/cubits/get_packages/get_packages_cubit.dart';
import '../../../home/presentation/cubits/get_registered_services_and_packages/get_registered_services_and_packages_cubit.dart';
import '../../../home/presentation/widgets/bottom_sheets/service_details.dart';

class PackageDetails extends StatefulWidget {
  const PackageDetails({super.key});

  @override
  State<PackageDetails> createState() => _PackageDetailsState();
}

class _PackageDetailsState extends State<PackageDetails> {
  late final GetRegisteredServicesAndPackagesCubit registeredCubit;
  late final GetPackagesCubit packagesCubit;

  @override
  void initState() {
    super.initState();
    registeredCubit = sl<GetRegisteredServicesAndPackagesCubit>();
    packagesCubit = sl<GetPackagesCubit>();

    registeredCubit.getRegisteredServicesAndPackages();
    packagesCubit.getPackages();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      GetRegisteredServicesAndPackagesCubit,
      GetRegisteredServicesAndPackagesState
    >(
      bloc: registeredCubit,
      builder: (context, state) {
        if (state is GetRegisteredServicesAndPackagesLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GetRegisteredServicesAndPackagesError) {
          return Center(
            child: CustomText(
              state.message,
              style: CustomStyleManger.heading1.copyWith(color: Colors.red, fontSize: 16),
            ),
          );
        }

        if (state is GetRegisteredServicesAndPackagesLoaded) {
          final result = state.response.result;

          /// ✅ دمج الباقات + الخدمات
          final List<ServiceOrPackage> items = [...?result?.bundles, ...?result?.services];

          if (items.isEmpty) {
            return const Center(child: Text("لا توجد اشتراكات متاحة"));
          }

          final firstItem = items.first;

          return Container(
            color: CustomColorsManager.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔹 العنوان
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      "الاشتراكات",
                      style: CustomStyleManger.heading1.copyWith(fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.subscriptionsScreen);
                      },
                      child: CustomText(
                        "عرض الكل",
                        style: CustomStyleManger.normalText.copyWith(
                          color: CustomColorsManager.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                /// ✅ عرض أول عنصر فقط
                SubscriptionItem(
                  bundleId: firstItem.id.toString(),
                  invoiceId: firstItem.invoiceId.toString(),
                  name: firstItem.name ?? 'باقة',
                  image: firstItem.images.isNotEmpty
                      ? firstItem.images.first
                      : CustomAssetsManager.test,
                  isBundle: firstItem.isBundle,
                  onServiceTap: (serviceId) {
                    final packagesState = packagesCubit.state;
                    if (packagesState is GetPackagesLoaded) {
                      final allPackages = packagesState.response.info ?? [];

                      final foundService = allPackages.firstWhere(
                        (pkg) => pkg.packageId.toString() == serviceId,
                        orElse: () => allPackages.first,
                      );

                      showServiceDetailsBottomSheet(
                        context,
                        GetServiceFromServiceIdRequest(
                          serviceId: foundService.packageId.toString(),
                          invoiceId: foundService.invoiceId.toString(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class SubscriptionItem extends StatelessWidget {
  final String bundleId;
  final String invoiceId;
  final String name;
  final String image;
  final bool isBundle;
  final void Function(String serviceId) onServiceTap;

  const SubscriptionItem({
    super.key,
    required this.bundleId,
    required this.invoiceId,
    required this.name,
    required this.image,
    required this.isBundle,
    required this.onServiceTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isBundle) {
          Get.toNamed(Routes.packagesFromBundleScreen, arguments: [bundleId, invoiceId]);
        } else {
          onServiceTap(bundleId);
        }
      },
      child: Card(
        elevation: 5,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        clipBehavior: Clip.antiAlias,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(aspectRatio: 2.5, child: CustomImage(imagePath: image)),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    name,
                    style: CustomStyleManger.heading1.copyWith(
                      fontSize: 15,
                      color: CustomColorsManager.black,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  ServiceFlag(isBundle: isBundle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceFlag extends StatelessWidget {
  final bool isBundle;

  const ServiceFlag({super.key, required this.isBundle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isBundle ? CustomColorsManager.primaryColor : CustomColorsManager.secondaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: CustomText(
          isBundle ? 'باقة' : 'خدمة',
          style: CustomStyleManger.normalText.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
