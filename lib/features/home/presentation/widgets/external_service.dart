import 'package:remotely/core/widgets/custom_button.dart';
import 'package:remotely/core/widgets/custom_image.dart';
import 'package:remotely/features/cart/presentation/cubit/cart/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../core/utils/style_manager/style_manager.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../injection_container/injection_container.dart';
import '../../data/models/responses/get_all_services_by_web_id_response.dart';

class ExternalService extends StatefulWidget {
  const ExternalService({
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
  final ServiceItem service;

  @override
  State<ExternalService> createState() => _ExternalServiceState();
}

class _ExternalServiceState extends State<ExternalService> {
  int quantity = 1;

  void _increaseQuantity() {
    setState(() => quantity++);
  }

  void _decreaseQuantity() {
    if (quantity > 1) setState(() => quantity--);
  }

  @override
  Widget build(BuildContext context) {
    final service = widget.service;

    final price = (service.subProductPrices != null && service.subProductPrices!.isNotEmpty)
        ? service.subProductPrices!.first.price.toString()
        : '';

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CustomColorsManager.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Builder(
                    builder: (context) {
                      final imageUrl =
                          (service.images != null &&
                              service.images!.isNotEmpty &&
                              (service.images!.first.fileLink?.isNotEmpty ?? false))
                          ? service.images!.first.fileLink!
                          : '';

                      return AspectRatio(
                        aspectRatio: 2.5,
                        child: CustomImage(imagePath: imageUrl.toString()),
                      );
                    },
                  ),
                ),
              ),
              // 🔹 Widget for quantity control
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.add, size: 18),
                        onPressed: _increaseQuantity,
                      ),
                      Text(
                        '$quantity',
                        style: CustomStyleManger.heading1.copyWith(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.remove, size: 18),
                        onPressed: _decreaseQuantity,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  service.service?.pkgName ?? '',
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  style: CustomStyleManger.heading1.copyWith(fontSize: 17),
                ),
                const SizedBox(height: 5),
                CustomText(
                  service.service?.details ?? '',
                  maxLines: 3,
                  textAlign: TextAlign.start,
                  style: CustomStyleManger.normalText.copyWith(
                    fontSize: 17,
                    color: CustomColorsManager.lightTextColor,
                  ),
                ),
                const SizedBox(height: 5),
                if (widget.withPrice)
                  CustomText(
                    "$price ر.س",
                    style: CustomStyleManger.heading1.copyWith(
                      fontSize: 15,
                      color: CustomColorsManager.primaryColor,
                    ),
                  ),
                const SizedBox(height: 10),
                if (widget.withAddCart || widget.withDetailsAndOrderService)
                  const SizedBox(height: 15),
                if (widget.withAddCart)
                  CustomButton(
                    text: "اضف للسلة",
                    onPressed: () {
                      Get.toNamed('/cart');
                    },
                    textColor: CustomColorsManager.white,
                  )
                else if (widget.withDetailsAndOrderService)
                  Row(
                    spacing: 15,
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: "أضف للسلة",
                          fontSize: 15,
                          onPressed: () {
                            for (int i = 0; i < quantity; i++) {
                              sl<CartCubit>().addService(service);
                            }
                          },
                          textColor: CustomColorsManager.white,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
