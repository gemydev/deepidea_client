import 'package:remotely/core/utils/assets_manager/assets_manager.dart';
import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_button.dart';
import 'package:remotely/core/widgets/custom_image.dart';
import 'package:remotely/core/widgets/custom_text.dart';
import 'package:remotely/features/support/presentation/widgets/sub_app_bar.dart';
import 'package:flutter/material.dart';

class FriendsInvitation extends StatefulWidget {
  const FriendsInvitation({super.key});

  @override
  State<FriendsInvitation> createState() => _FriendsInvitationState();
}

class _FriendsInvitationState extends State<FriendsInvitation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColorsManager.scaffoldBGColor,
      body: SafeArea(
        child: Column(
          children: [
            SubAppBar(title: "دعوة لاصدقائك"),
            SizedBox(height: 10),
            Container(
              color: CustomColorsManager.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          "أعط ",
                          style: CustomStyleManger.normalText.copyWith(
                            color: CustomColorsManager.mainTextColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 5),
                        CustomText(
                          "100ر.س",
                          style: CustomStyleManger.normalText.copyWith(
                            color: CustomColorsManager.appGreen,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 5),
                        CustomText(
                          "واحصل على",
                          style: CustomStyleManger.normalText.copyWith(
                            color: CustomColorsManager.mainTextColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 5),
                        CustomText(
                          "100ر.س",
                          style: CustomStyleManger.normalText.copyWith(
                            color: CustomColorsManager.appGreen,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 5),
                      ],
                    ),
                    SizedBox(height: 10),
                    CustomText(
                      "لكل صديق اشترك",
                      style: CustomStyleManger.normalText.copyWith(fontSize: 15),
                    ),
                    SizedBox(height: 20),
                    InvitationItem(
                      imagePath: CustomAssetsManager.inviteFriend,
                      title: "ادعو صديقك",
                    ),
                    SizedBox(height: 25),
                    InvitationItem(
                      imagePath: CustomAssetsManager.loveEmoticon,
                      title: "اصدقائك يحصلون علي 100 ر.س عندما  يشتركون",
                    ),
                    SizedBox(height: 25),
                    InvitationItem(
                      imagePath: CustomAssetsManager.notoWrapped,
                      title: "تحصل على رصيد إحالة بقيمة 100ر.س عند إضافة اشتراكك أو استخدامه كخصم",
                    ),
                    SizedBox(height: 30),
                    CustomButton(text: "دعوة لاصدقائك", textColor: CustomColorsManager.white),
                    SizedBox(height: 20),
                    Center(
                      child: CustomText(
                        "أو اضغط لنسخ رمز الدعوة",
                        style: CustomStyleManger.normalText.copyWith(
                          fontSize: 15,
                          color: CustomColorsManager.lightTextColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: CustomColorsManager.primaryColor),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomImage(imagePath: CustomAssetsManager.simcard, height: 25),
                              SizedBox(width: 5),
                              CustomText(
                                "YASMIN232",
                                style: CustomStyleManger.normalText.copyWith(
                                  color: CustomColorsManager.primaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              color: CustomColorsManager.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        CustomText("0", style: CustomStyleManger.heading1.copyWith(fontSize: 22)),
                        CustomText(
                          "اصدقاء اشتركت",
                          style: CustomStyleManger.normalText.copyWith(
                            color: CustomColorsManager.lightTextColor,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    VerticalDivider(),
                    Column(
                      children: [
                        CustomText(
                          "0 ر.س",
                          style: CustomStyleManger.heading1.copyWith(fontSize: 22),
                        ),
                        CustomText(
                          "حصل حتى الآن",
                          style: CustomStyleManger.normalText.copyWith(
                            color: CustomColorsManager.lightTextColor,
                            fontSize: 20,
                          ),
                        ),
                      ],
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

class InvitationItem extends StatelessWidget {
  const InvitationItem({super.key, required this.title, required this.imagePath});

  final String title;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: CustomColorsManager.white,
            shape: BoxShape.circle,
            border: Border.all(color: CustomColorsManager.unSelectedBorderColor),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomImage(imagePath: imagePath, height: 25),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: CustomText(
            title,
            textAlign: TextAlign.start,
            maxLines: 3,
            style: CustomStyleManger.normalText.copyWith(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
