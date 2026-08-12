import 'package:remotely/core/utils/assets_manager/assets_manager.dart';
import 'package:remotely/core/widgets/custom_button.dart';
import 'package:remotely/core/widgets/custom_image.dart';
import 'package:remotely/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../core/utils/style_manager/style_manager.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../cart/presentation/cubit/cart/cart_cubit.dart';
import '../../../home/presentation/cubits/get_list_of_packages_with_fav/get_list_of_packages_with_fav_cubit.dart';
import '../../data/models/responses/get_services_list_of_packages_with_fav_response.dart';

/// شاشة استكشاف الخطط
class PlanExploration extends StatefulWidget {
  const PlanExploration({super.key});

  @override
  State<PlanExploration> createState() => _PlanExplorationState();
}

class _PlanExplorationState extends State<PlanExploration> {
  final getServicesCubit = sl<GetServicesListOfPackagesWithFavCubit>();

  @override
  void initState() {
    super.initState();
    // ✅ تحميل بيانات الخدمتين (4 و5)
    getServicesCubit.getMultiplePackages(["4", "5"]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      GetServicesListOfPackagesWithFavCubit,
      GetServicesListOfPackagesWithFavState
    >(
      bloc: getServicesCubit,
      builder: (context, state) {
        return switch (state) {
          GetServicesListOfPackagesWithFavLoading() => const Center(
            child: CircularProgressIndicator(),
          ),

          GetServicesListOfPackagesWithFavError() => Center(
            child: CustomText(
              "حدث خطأ أثناء تحميل الخطط",
              style: CustomStyleManger.normalText.copyWith(color: CustomColorsManager.red),
            ),
          ),

          GetServicesListOfPackagesWithFavLoaded(:final response) => _buildPlans(
            response.result ?? [],
          ),

          _ => const SizedBox(),
        };
      },
    );
  }

  Widget _buildPlans(List<Package> packages) {
    if (packages.isEmpty) {
      return Center(
        child: CustomText(
          "لا توجد خطط متاحة حالياً",
          style: CustomStyleManger.normalText.copyWith(color: CustomColorsManager.lightTextColor),
        ),
      );
    }

    return Container(
      color: CustomColorsManager.white,
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              "استكشف الخطط لدينا",
              style: CustomStyleManger.heading1.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 15),
            Column(spacing: 12, children: packages.map((pkg) => PackageItem(pkg: pkg)).toList()),
          ],
        ),
      ),
    );
  }
}

/// عنصر عرض باقة واحدة
class PackageItem extends StatelessWidget {
  final Package pkg;

  const PackageItem({super.key, required this.pkg});

  @override
  Widget build(BuildContext context) {
    final title = pkg.packageName ?? "خطة بدون اسم";
    final price = pkg.priceDetails?.cost?.toDouble() ?? 0;
    final period = "";
    final isFavourite = pkg.isFavorite ?? false;
    final features =
        pkg.subFeatures?.map((e) => e.features ?? "").where((e) => e.isNotEmpty).toList() ?? [];

    final mid = (features.length / 2).ceil();
    final leftFeatures = features.take(mid).toList();
    final rightFeatures = features.skip(mid).toList();

    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: CustomColorsManager.unSelectedBorderColor),
            color: CustomColorsManager.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              CustomText(title, style: CustomStyleManger.heading1.copyWith(fontSize: 18)),
              Row(
                children: [
                  CustomText(
                    "${price.toStringAsFixed(2)} ر.س",
                    style: CustomStyleManger.heading1.copyWith(fontSize: 15),
                  ),
                  if (period.isNotEmpty) ...[
                    const SizedBox(width: 5),
                    CustomText(
                      "/ $period",
                      style: CustomStyleManger.heading1.copyWith(
                        fontSize: 13,
                        color: CustomColorsManager.yellowColor,
                      ),
                    ),
                  ],
                ],
              ),
              const Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(flex: 1, child: _buildFeatureColumn(leftFeatures)),
                  const SizedBox(width: 10),
                  Flexible(flex: 1, child: _buildFeatureColumn(rightFeatures)),
                ],
              ),
              const SizedBox(height: 15),
              CustomButton(
                text: "أضف للسلة",
                textColor: CustomColorsManager.white,
                onPressed: () => sl<CartCubit>().addPackage(pkg),
              ),
            ],
          ),
        ),

        if (isFavourite) const _BestSellerBadge(),
      ],
    );
  }

  Widget _buildFeatureColumn(List<String> items) =>
      Column(spacing: 5, children: items.map((e) => FeatureItem(text: e)).toList());
}

/// عنصر ميزة واحدة داخل الباقة
class FeatureItem extends StatelessWidget {
  final String text;

  const FeatureItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomImage(imagePath: CustomAssetsManager.tickCircle, height: 15),
        const SizedBox(width: 6),
        Expanded(
          child: CustomText(
            text,
            style: CustomStyleManger.normalText.copyWith(
              fontSize: 13,
              color: CustomColorsManager.lightTextColor,
            ),
          ),
        ),
      ],
    );
  }
}

/// شارة "الأفضل مبيعًا"
class _BestSellerBadge extends StatelessWidget {
  const _BestSellerBadge();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 25,
      left: -32,
      child: Transform.rotate(
        angle: -0.785398, // -45°
        child: Container(
          width: 120,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF6DB6A3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              "الأفضل مبيعًا",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
            ),
          ),
        ),
      ),
    );
  }
}
