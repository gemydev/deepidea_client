import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_text.dart';
import 'package:remotely/features/support/presentation/widgets/sub_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/routes_manager/routes_manager.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColorsManager.scaffoldBGColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SubAppBar(title: "الدفع"),
            SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: CustomColorsManager.white,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText("كيف تريد الدفع؟", style: CustomStyleManger.heading1),
                              CustomText(
                                "نحن نحمي ونؤمن معلوماتك.",
                                style: CustomStyleManger.normalText.copyWith(
                                  fontSize: 17,
                                  color: CustomColorsManager.mainTextColor.withValues(alpha: 0.7),
                                ),
                              ),
                              SizedBox(height: 25),
                              SizedBox(height: 25),
                              PaymentItem(title: "رقم البطاقة", data: "ادخل رقم البطاقة"),
                              SizedBox(height: 10),
                              PaymentItem(title: "اسم صاحب البطاقة", data: "ادخل اسم صاحب البطاقة"),
                              SizedBox(height: 10),
                              PaymentItem(
                                title: "تاريخ إنتهاء البطاقة",
                                data: "ادخل تاريخ إنتهاء البطاقة",
                              ),
                              SizedBox(height: 10),
                              PaymentItem(title: "كود التحقق (CVC)", data: "ادخل كود التحقق (CVC)"),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                // Align to the right for RTL
                                children: [
                                  CustomText(
                                    'حفظ بيانات البطاقة',
                                    style: CustomStyleManger.normalText.copyWith(fontSize: 20),
                                  ),
                                  const SizedBox(width: 10),
                                  CupertinoSwitch(
                                    value: switchValue,
                                    onChanged: (bool value) {
                                      setState(() {
                                        switchValue = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: CustomColorsManager.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.edfaaPayScreen);
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: CustomColorsManager.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: CustomText(
                        "الدفع",
                        style: CustomStyleManger.normalText.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: CustomColorsManager.white,
                        ),
                      ),
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
}

class PaymentItem extends StatelessWidget {
  const PaymentItem({super.key, required this.title, required this.data});

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: CustomColorsManager.white,
            border: Border.all(color: CustomColorsManager.unSelectedBorderColor),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomText(
                      title,
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      style: CustomStyleManger.normalText.copyWith(
                        fontSize: 22,
                        color: CustomColorsManager.mainTextColor,
                      ),
                    ),
                    CustomText(
                      " *",
                      textAlign: TextAlign.start,
                      maxLines: 3,
                      style: CustomStyleManger.normalText.copyWith(
                        fontSize: 22,
                        color: CustomColorsManager.red,
                      ),
                    ),
                  ],
                ),
                CustomText(
                  data,
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  style: CustomStyleManger.normalText.copyWith(
                    fontSize: 15,
                    color: CustomColorsManager.grayTextColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
