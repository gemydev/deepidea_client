import 'package:remotely/core/utils/assets_manager/assets_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_image.dart';
import 'package:remotely/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../support/presentation/widgets/sub_app_bar.dart';
import '../widgets/order_tap_bar.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  int selectedIndex = 0;
  int chipSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColorsManager.scaffoldBGColor,
      body: SafeArea(
        child: Column(
          children: [
            const SubAppBar(title: "الطلبات", withBottomPadding: false),
            OrderTabBar(
              listOfTitles: ['الطلبات الحالية', 'الطلبات السابقة'],
              selectedIndex: selectedIndex,
              onTabChanged: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
                child: selectedIndex == 0
                    ? Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  OrderExpansionTile(),
                                  SizedBox(height: 10),
                                  OrderExpansionTile(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: CustomColorsManager.profileBGColor,
                              border: Border.all(color: CustomColorsManager.unSelectedBorderColor),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: CustomImage(
                                imagePath: CustomAssetsManager.bagHappy,
                                height: 65,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          CustomText(
                            "لم تقم بطلب أي خدمات حتي الان",
                            style: CustomStyleManger.normalText.copyWith(fontSize: 25),
                          ),
                          CustomText(
                            "قم بطلب خدمات وقم بمتابعة خدماتك من خلال طلباتي",
                            maxLines: 2,
                            style: CustomStyleManger.normalText.copyWith(
                              fontSize: 20,
                              color: CustomColorsManager.lightTextColor,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderExpansionTile extends StatelessWidget {
  const OrderExpansionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColorsManager.white,
      child: ExpansionTile(
        shape: Border.all(color: Colors.transparent),
        collapsedShape: Border.all(color: Colors.transparent),
        title: Column(
          children: [
            OrderDataItem(
              title: "145587452225",
              data: "رقم الطلب",
              imagePath: CustomAssetsManager.hashtag,
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: OrderDataItem(
                    title: "May 4, 2023 ",
                    data: "تاريخ الطلب",
                    imagePath: CustomAssetsManager.calendarBlue,
                  ),
                ),
                Expanded(
                  child: OrderDataItem(
                    title: "4000 ر.س",
                    titleColor: CustomColorsManager.primaryColor,
                    data: "الإجمالي",
                    imagePath: CustomAssetsManager.receipt,
                  ),
                ),
              ],
            ),
          ],
        ),
        children: [OrderItem(), Divider(), OrderItem()],
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  const OrderItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            height: 75,
            width: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(CustomAssetsManager.test),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: [
                        CustomText(
                          "اقرار ضريبي",
                          style: CustomStyleManger.normalText.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        RowOfTexts(text1: "رقم التسجيل: ", text2: "#454"),
                        RowOfTexts(
                          mainAxisAlignment: MainAxisAlignment.end,
                          text1: "وقت الانتهاء: ",
                          text2: "6ص-10 ص",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RowOfTexts extends StatelessWidget {
  const RowOfTexts({
    super.key,
    required this.text1,
    required this.text2,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  final String text1;
  final String text2;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        CustomText(
          text1,
          style: CustomStyleManger.normalText.copyWith(
            color: CustomColorsManager.lightTextColor,
            fontSize: 13,
          ),
        ),
        Expanded(
          child: CustomText(
            text2,
            textAlign: TextAlign.start,
            style: CustomStyleManger.normalText.copyWith(fontSize: 13),
          ),
        ),
      ],
    );
  }
}

class OrderDataItem extends StatelessWidget {
  const OrderDataItem({
    super.key,
    required this.title,
    required this.data,
    required this.imagePath,
    this.titleColor,
  });

  final String title;
  final String data;
  final String imagePath;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomImage(imagePath: imagePath, height: 20),
        SizedBox(width: 5),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title,
                textAlign: TextAlign.start,
                maxLines: 3,
                style: CustomStyleManger.normalText.copyWith(
                  fontSize: 13,
                  color: titleColor ?? CustomColorsManager.mainTextColor,
                ),
              ),
              CustomText(
                data,
                textAlign: TextAlign.start,
                maxLines: 3,
                style: CustomStyleManger.normalText.copyWith(
                  fontSize: 13,
                  color: CustomColorsManager.lightTextColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
