import 'package:remotely/core/utils/assets_manager/assets_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_image.dart';
import 'package:remotely/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../cart/presentation/cubit/cart/cart_cubit.dart';
import '../../data/models/responses/get_all_services_by_web_id_response.dart';

class ServiceDetails extends StatefulWidget {
  const ServiceDetails({super.key});

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  late final bool fromAddition;
  late final bool withRating;
  late final ServiceItem serviceItem;

  int currentRate = 1;

  @override
  void initState() {
    super.initState();

    fromAddition = Get.arguments[0] as bool;
    withRating = Get.arguments[1] as bool;
    serviceItem = Get.arguments[2] as ServiceItem;

    if (withRating) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // CustomBottomSheets.showNotesAdditionBottomSheet(context);
        // CustomBottomSheets.showServiceRateBottomSheet(
        //   context,
        //   currentRate: currentRate,
        //   onRatingChanged: (rate) {
        //     setState(() => currentRate = rate);
        //   },
        // );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final service = serviceItem.service;

    // صورة الخدمة
    final imagePath =
        (serviceItem.images != null &&
            serviceItem.images!.isNotEmpty &&
            serviceItem.images!.first.fileLink != null)
        ? serviceItem.images!.first.fileLink!
        : CustomAssetsManager.test;

    // السعر: لو في subProductPrices نعرض أول سعر، لو لا نعرض 0
    final price = serviceItem.subProductPrices != null && serviceItem.subProductPrices!.isNotEmpty
        ? serviceItem.subProductPrices!.first.price ?? 0
        : 0;

    return Scaffold(
      backgroundColor: CustomColorsManager.scaffoldBGColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// صورة الخدمة
                    Stack(
                      children: [
                        CustomImage(
                          imagePath: imagePath,
                          width: double.infinity,
                          height: 220,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 15,
                          right: 15,
                          child: GestureDetector(
                            onTap: Get.back,
                            child: _circleIcon(Icons.arrow_back),
                          ),
                        ),
                      ],
                    ),

                    /// محتوى الخدمة
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// اسم الخدمة
                          CustomText(
                            service?.pkgName ?? service?.productName ?? "اسم الخدمة",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: CustomStyleManger.heading1,
                          ),
                          const SizedBox(height: 5),

                          /// تفاصيل الخدمة
                          if (service?.details != null && service!.details!.isNotEmpty)
                            CustomText(
                              service.details!,
                              maxLines: 5,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: CustomStyleManger.normalText.copyWith(
                                fontSize: 15,
                                color: CustomColorsManager.lightTextColor,
                              ),
                            ),

                          const SizedBox(height: 15),

                          /// السعر الأصلي (خط)
                          Row(
                            children: [
                              CustomText(
                                "${price.toStringAsFixed(2)} ر.س",
                                style: CustomStyleManger.heading1.copyWith(
                                  fontSize: 20,
                                  color: CustomColorsManager.primaryColor,
                                ),
                              ),
                              // const SizedBox(width: 10),
                              // if (serviceItem.subProductPrices != null &&
                              //     serviceItem.subProductPrices!.length > 1)
                              //   CustomText(
                              //     "${serviceItem.subProductPrices![1].price?.toStringAsFixed(2) ?? 0} ر.س",
                              //     style: CustomStyleManger.normalText.copyWith(
                              //       fontSize: 15,
                              //       decoration: TextDecoration.lineThrough,
                              //       color: CustomColorsManager.lightTextColor,
                              //     ),
                              //   ),
                            ],
                          ),

                          const SizedBox(height: 15),

                          /// تقييم الخدمة ووقت التنفيذ
                          Row(
                            children: [
                              // _infoItem(
                              //   CustomAssetsManager.star,
                              //   service?.pointCategoryName ?? "0.0",
                              // ),
                              // const SizedBox(width: 20),
                              _infoItem(
                                CustomAssetsManager.clock,
                                "${service?.measureCount} ${service?.measureName}",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// إضافة ملاحظات
                    // if (withRating)
                    //   ServiceOptionCard(
                    //     title: "هل تريد اضافة ملاحظات؟",
                    //     actionText: "اضافة ملاحظة",
                    //     imagePath: CustomAssetsManager.messageText,
                    //     onTap: () {
                    //       CustomBottomSheets.showNotesAdditionBottomSheet(
                    //         context,
                    //       );
                    //     },
                    //   ),
                    //
                    // if (withRating) const SizedBox(height: 10),
                    //
                    // /// إضافة تقييم
                    // if (withRating)
                    //   ServiceOptionCard(
                    //     title: "هل تريد اضافة تقييم؟",
                    //     actionText: "اضافة تقييم",
                    //     imagePath: CustomAssetsManager.starBorder,
                    //     onTap: () {
                    //       CustomBottomSheets.showServiceRateBottomSheet(
                    //         context,
                    //         currentRate: currentRate,
                    //         onRatingChanged: (rate) {
                    //           setState(() => currentRate = rate);
                    //         },
                    //       );
                    //     },
                    //   ),
                    const SizedBox(height: 10),

                    /// الخدمات الإضافية
                    if (fromAddition)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              "عادةً يحتاج إلي",
                              style: CustomStyleManger.heading1.copyWith(fontSize: 22),
                            ),
                            const SizedBox(height: 10),
                            Column(
                              children: serviceItem.packagesAttributes != null
                                  ? serviceItem.packagesAttributes!
                                        .map((attr) => Text(attr.toString()))
                                        .toList()
                                  : [],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),

            /// زر إضافة إلى السلة
            Container(
              color: CustomColorsManager.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: GestureDetector(
                  onTap: () {
                    sl<CartCubit>().addService(serviceItem);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: CustomColorsManager.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          "اضافة الي السلة",
                          style: CustomStyleManger.normalText.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: CustomColorsManager.white,
                          ),
                        ),
                        CustomText(
                          "${price.toStringAsFixed(2)} ر.س",
                          style: CustomStyleManger.normalText.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: CustomColorsManager.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// HELPER WIDGETS
  Widget _circleIcon(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColorsManager.white,
        shape: BoxShape.circle,
        border: Border.all(color: CustomColorsManager.unSelectedBorderColor),
      ),
      padding: const EdgeInsets.all(7),
      child: Icon(icon, color: CustomColorsManager.lightTextColor),
    );
  }

  Widget _infoItem(String icon, String text) {
    return Row(
      children: [
        CustomImage(imagePath: icon, height: 20),
        const SizedBox(width: 5),
        CustomText(text, style: CustomStyleManger.normalText.copyWith(fontSize: 17)),
      ],
    );
  }
}

class ServiceOptionCard extends StatelessWidget {
  const ServiceOptionCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.actionText,
    this.onTap,
  });

  final String imagePath;
  final String title;
  final String actionText;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColorsManager.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CustomImage(imagePath: imagePath, height: 20),
              const SizedBox(width: 10),
              CustomText(title, style: CustomStyleManger.normalText.copyWith(fontSize: 17)),
            ],
          ),
          GestureDetector(
            onTap: onTap,
            child: CustomText(
              actionText,
              style: CustomStyleManger.normalText.copyWith(
                fontSize: 17,
                color: CustomColorsManager.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
