import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_text.dart';
import 'package:remotely/features/support/presentation/widgets/sub_app_bar.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColorsManager.scaffoldBGColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SubAppBar(
              title: "الاشعارات",
              widget: CustomText(
                "مسح الكل",
                style: CustomStyleManger.normalText.copyWith(
                  color: CustomColorsManager.appRed,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                child: Column(
                  children: [
                    NotificationItem(),
                    SizedBox(height: 15),
                    NotificationItem(),
                    SizedBox(height: 15),
                    NotificationItem(),
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

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: CustomColorsManager.white),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              "June 31, 2023",
              style: CustomStyleManger.normalText.copyWith(color: CustomColorsManager.green),
            ),
            SizedBox(height: 5),
            CustomText(
              "أخبار رائعة! تمت إضافة منتج جديد وفئات جديدة ",
              maxLines: 1,
              style: CustomStyleManger.normalText.copyWith(
                color: CustomColorsManager.black,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 5),
            CustomText(
              "هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص أو شكل توضع الفقرات في الصفحة التي يقرأها.",
              maxLines: 2,
              style: CustomStyleManger.normalText.copyWith(
                color: CustomColorsManager.grayTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
