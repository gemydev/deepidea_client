import 'package:remotely/core/widgets/custom_button.dart';
import 'package:remotely/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../core/utils/routes_manager/routes_manager.dart';
import '../../../../core/utils/style_manager/style_manager.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../data/models/requests/get_service_from_service_id.dart';
import '../../data/models/responses/get_package_response.dart';
import 'bottom_sheets/service_details.dart';

class AAPService extends StatelessWidget {
  const AAPService({
    super.key,
    this.withAddCart = false,
    this.withPrice = true,
    this.fromAddition = false,
    this.withDetailsAndOrderService = false,
    required this.service,
  });

  final bool withAddCart;
  final bool withDetailsAndOrderService;
  final bool withPrice;
  final bool fromAddition;
  final ServicePackage service;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CustomColorsManager.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Builder(
                builder: (context) {
                  final imageUrl =
                      (service.imageLinks != null &&
                          service.imageLinks!.isNotEmpty &&
                          (service.imageLinks!.first.isNotEmpty))
                      ? service.imageLinks!.first
                      : null;

                  return AspectRatio(
                    aspectRatio: 2.5,
                    child: CustomImage(imagePath: imageUrl.toString()),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomText(
                        service.packageName ?? '',
                        textAlign: TextAlign.start,
                        style: CustomStyleManger.heading1.copyWith(fontSize: 17),
                      ),
                    ),
                    const SizedBox(width: 8),
                    withPrice
                        ? CustomText(
                            "2000 ر.س",
                            style: CustomStyleManger.heading1.copyWith(
                              fontSize: 15,
                              color: CustomColorsManager.primaryColor,
                            ),
                          )
                        : Container(),
                  ],
                ),
                const SizedBox(height: 5),
                CustomText(
                  service.packageDetails ?? '',
                  maxLines: 3,
                  textAlign: TextAlign.start,
                  style: CustomStyleManger.normalText.copyWith(
                    fontSize: 17,
                    color: CustomColorsManager.lightTextColor,
                  ),
                ),
                const SizedBox(height: 10),
                // Row(
                //   children: [
                //     Row(
                //       children: [
                //         const CustomImage(
                //           imagePath: CustomAssetsManager.star,
                //           height: 15,
                //         ),
                //         const SizedBox(
                //           width: 5,
                //         ),
                //         CustomText(
                //           "4.0",
                //           style: CustomStyleManger.normalText
                //               .copyWith(fontSize: 17),
                //         ),
                //       ],
                //     ),
                //     const SizedBox(
                //       width: 20,
                //     ),
                //     Row(
                //       children: [
                //         const CustomImage(
                //           imagePath: CustomAssetsManager.clock,
                //           height: 20,
                //         ),
                //         const SizedBox(
                //           width: 5,
                //         ),
                //         CustomText(
                //           "2 أسبوع من بداية الحجز",
                //           style: CustomStyleManger.normalText.copyWith(
                //               fontSize: 17,
                //               color: CustomColorsManager.lightTextColor),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
                SizedBox(height: withAddCart || withDetailsAndOrderService ? 15 : 0),
                withAddCart
                    ? CustomButton(
                        text: "اضف للسلة",
                        onPressed: () {
                          Get.toNamed(Routes.cart);
                        },
                        textColor: CustomColorsManager.white,
                      )
                    : withDetailsAndOrderService
                    ? Row(
                        spacing: 15,
                        children: [
                          Expanded(
                            child: CustomButton(
                              text: "تفاصيل الخدمة",
                              backGroundColor: CustomColorsManager.white,
                              fontSize: 15,
                              borderColor: CustomColorsManager.primaryColor,
                              onPressed: () {
                                showServiceDetailsBottomSheet(
                                  context,
                                  GetServiceFromServiceIdRequest(
                                    serviceId: service.packageId.toString(),
                                    invoiceId: service.invoiceId.toString(),
                                  ),
                                );
                              },
                              textColor: CustomColorsManager.mainTextColor,
                            ),
                          ),
                          Expanded(
                            child: CustomButton(
                              text: "طلب الخدمة",
                              fontSize: 15,
                              onPressed: () {
                                Get.toNamed(Routes.orderService, arguments: [service]);
                              },
                              textColor: CustomColorsManager.white,
                            ),
                          ),
                        ],
                      )
                    : Container(),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
