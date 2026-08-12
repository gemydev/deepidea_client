import 'dart:math';

import 'package:remotely/core/widgets/custom_image.dart';
import 'package:remotely/features/home/data/models/responses/get_packages_from_package_bundle_response.dart';
import 'package:remotely/features/progress/presentation/widgets/custom_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../core/utils/style_manager/style_manager.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../home/data/models/requests/get_packages_from_backage_bundel.dart';
import '../../../home/presentation/cubits/get_packages_from_package_bundle/get_packages_from_package_bundle_cubit.dart';
import '../../../support/presentation/widgets/sub_app_bar.dart';
import '../widgets/package_details.dart';

class PackagesFromBundleScreen extends StatefulWidget {
  const PackagesFromBundleScreen({super.key});

  @override
  State<PackagesFromBundleScreen> createState() => _PackagesFromBundleScreenState();
}

class _PackagesFromBundleScreenState extends State<PackagesFromBundleScreen> {
  late final GetPackagesFromPackageBundleCubit cubit;
  late final String bundleId;
  late final String invoiceId;

  @override
  void initState() {
    super.initState();
    bundleId = Get.arguments[0];
    invoiceId = Get.arguments[1];
    cubit = sl<GetPackagesFromPackageBundleCubit>()
      ..getPackagesFromPackageBundle(
        GetPackagesFromPackageBundleRequest(invoiceId: invoiceId, bundleId: bundleId),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        backgroundColor: CustomColorsManager.scaffoldBGColor,
        body: SafeArea(
          child: Column(
            children: [
              const SubAppBar(title: "تفاصيل الباقة"),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child:
                      BlocBuilder<
                        GetPackagesFromPackageBundleCubit,
                        GetPackagesFromPackageBundleState
                      >(
                        builder: (context, state) {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: switch (state) {
                              GetPackagesFromPackageBundleLoading() => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              GetPackagesFromPackageBundleError() => Center(
                                child: CustomText(
                                  'حدث خطأ أثناء تحميل تفاصيل الباقة.',
                                  color: Colors.red,
                                ),
                              ),
                              GetPackagesFromPackageBundleLoaded() => _buildList(
                                state.response.result ?? [],
                              ),
                              _ => const SizedBox.shrink(),
                            },
                          );
                        },
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList(List<PackageBundleItem> items) {
    if (items.isEmpty) {
      return const Center(
        child: CustomText('لا توجد بيانات متاحة لهذه الباقة.', fontSize: 16, color: Colors.grey),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.only(top: 10, bottom: 80), // ✅ مساحة سفلية إضافية
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) => ServiceItem(item: items[index]),
    );
  }
}

class ServiceItem extends StatelessWidget {
  const ServiceItem({super.key, required this.item});

  final PackageBundleItem item;

  @override
  Widget build(BuildContext context) {
    // temporary placeholder
    final totalQty = (item.quantity ?? 1);
    final usedQty = item.usedQty ?? 0;

    final percentage = min(100, ((usedQty / max(1, totalQty)) * 100).toInt());

    return Card(
      elevation: 6,
      shadowColor: Colors.black26,
      color: CustomColorsManager.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🖼️ صورة الخدمة
          AspectRatio(
            aspectRatio: 2.5,
            child: CustomImage(
              imagePath: (item.images != null && item.images!.isNotEmpty) ? item.images!.first : "",
            ),
          ),

          // 📋 التفاصيل
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 العنوان والفئة
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      "الفئة",
                      style: CustomStyleManger.normalText.copyWith(
                        color: CustomColorsManager.grayTextColor,
                        fontSize: 14,
                      ),
                    ),
                    ServiceFlag(isBundle: false),
                  ],
                ),

                const SizedBox(height: 10),

                // 🔹 اسم الخدمة
                _infoRow("اسم الخدمة", item.packageName ?? 'خدمة غير معروفة'),

                const SizedBox(height: 8),

                // 💰 السعر
                _infoRow("السعر", '${item.unitPrice ?? 0} ر.س'),

                const SizedBox(height: 8),

                // ⏱ مدة التنفيذ
                _infoRow("مدة التنفيذ", '${item.executionTime ?? '-'} يوم'),

                const SizedBox(height: 55),

                // 🔹 شريط التقدم
                CustomProgressWidget(percentage: percentage),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          label,
          style: CustomStyleManger.normalText.copyWith(
            color: CustomColorsManager.grayTextColor,
            fontSize: 14,
          ),
        ),
        Flexible(
          child: CustomText(
            value,
            textAlign: TextAlign.end,
            style: CustomStyleManger.heading1.copyWith(
              fontSize: 15,
              color: CustomColorsManager.black,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
