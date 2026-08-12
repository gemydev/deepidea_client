import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/widgets/custom_text.dart';
import 'package:remotely/features/home/presentation/cubits/get_all_services_by_web_id/get_all_services_by_web_id_cubit.dart';
import 'package:remotely/features/home/presentation/cubits/get_packages/get_packages_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/utils/assets_manager/assets_manager.dart';
import '../../../../core/utils/routes_manager/routes_manager.dart';
import '../../../../core/utils/style_manager/style_manager.dart';
import '../../../../core/widgets/custom_image.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../servicies/presentaion/widgets/empty_state.dart';
import '../../data/models/responses/get_all_services_by_web_id_response.dart';
import '../../data/models/responses/get_package_response.dart';
import 'aap_service.dart';
import 'external_service.dart';

class OurServices extends StatefulWidget {
  const OurServices({super.key});

  @override
  State<OurServices> createState() => _OurServicesState();
}

class _OurServicesState extends State<OurServices> {
  late final GetPackagesCubit getPackagesCubit;
  late final GetAllServicesByWebIdCubit getAllServicesByWebIdCubit;

  @override
  void initState() {
    super.initState();
    getPackagesCubit = sl<GetPackagesCubit>()..getPackages();
    getAllServicesByWebIdCubit = sl<GetAllServicesByWebIdCubit>()..getAllServicesByWebId();
  }

  ServiceItem? _firstExternalService(GetAllServicesByWebIdState state) {
    if (state is GetAllServicesByWebIdLoaded) {
      final list = (state.response.result ?? [])
          .where((s) => !(s.service?.pkgName?.contains('باقة') ?? false))
          .toList();
      if (list.isNotEmpty) return list.first;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColorsManager.white,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: BlocBuilder<GetPackagesCubit, GetPackagesState>(
          bloc: getPackagesCubit,
          builder: (context, packageState) {
            return BlocBuilder<GetAllServicesByWebIdCubit, GetAllServicesByWebIdState>(
              bloc: getAllServicesByWebIdCubit,
              builder: (context, serviceState) {
                ServicePackage? firstPackage;
                ServiceItem? firstService = _firstExternalService(serviceState);
                String title = "الخدمات";
                Widget content;

                // ✅ إذا فيه package
                if (packageState is GetPackagesLoaded &&
                    packageState.response.info?.isNotEmpty == true) {
                  firstPackage = packageState.response.info!.first;
                  title = "خدماتي";
                }
                // ✅ لو مفيش package لكن فيه service
                else if (firstService != null) {
                  title = "الخدمات";
                }

                // ✅ تحديد العنصر المعروض
                if (firstPackage != null) {
                  content = AAPService(
                    withPrice: false,
                    fromAddition: true,
                    withDetailsAndOrderService: true,
                    service: firstPackage,
                  );
                } else if (firstService != null) {
                  content = ExternalService(
                    withPrice: true,
                    fromAddition: true,
                    withDetailsAndOrderService: true,
                    service: firstService,
                  );
                } else {
                  content = const EmptyStateWidget(message: 'لا توجد خدمات متاحة.');
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CustomText(
                              title,
                              style: CustomStyleManger.heading1.copyWith(fontSize: 20),
                            ),
                            const SizedBox(width: 5),
                            CustomImage(imagePath: CustomAssetsManager.rocket),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => Get.toNamed(Routes.servicesAndAdditions),
                          child: CustomText(
                            "عرض الكل",
                            style: CustomStyleManger.normalText.copyWith(
                              fontSize: 15,
                              color: CustomColorsManager.lightTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    content,
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
