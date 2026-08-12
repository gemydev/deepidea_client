import 'package:remotely/core/utils/assets_manager/assets_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_image.dart';
import 'package:remotely/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../home/presentation/cubits/get_list_of_packages_with_fav/get_list_of_packages_with_fav_cubit.dart';
import '../widgets/subscription_card.dart';

class CompaniesActivities extends StatefulWidget {
  const CompaniesActivities({super.key});

  @override
  State<CompaniesActivities> createState() => _CompaniesActivitiesState();
}

class _CompaniesActivitiesState extends State<CompaniesActivities> {
  GetServicesListOfPackagesWithFavCubit getServicesListOfPackagesWithFavCubit =
      sl<GetServicesListOfPackagesWithFavCubit>();

  @override
  void initState() {
    getServicesListOfPackagesWithFavCubit.getServicesListOfPackagesWithFav("5");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColorsManager.scaffoldBGColor,
      body: Column(
        children: [
          Stack(
            children: [
              const CustomImage(imagePath: CustomAssetsManager.companies, width: double.infinity),
              Positioned(
                top: 55,
                right: 15,
                child: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: CustomColorsManager.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: CustomColorsManager.unSelectedBorderColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Icon(Icons.arrow_back, color: CustomColorsManager.lightTextColor),
                    ),
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10, left: 10, top: 15),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 10,
                  children: [
                    Column(
                      spacing: 10,
                      children: [
                        CustomText(
                          "معبرك لاستراتيجية أعمالك و التقدم",
                          style: CustomStyleManger.normalText.copyWith(
                            color: CustomColorsManager.mainTextColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CustomText(
                          "بدلًا من الدفع للمحامي بالساعة، ادفع رسمًا شهريًا بسيطًا واحصل على محام يمكنه تقديم المشورة لك",
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          style: CustomStyleManger.normalText.copyWith(
                            color: CustomColorsManager.mainTextColor,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    Divider(thickness: 0.8, height: 20),
                    Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          "علي ماذا ستحصل اذا تعاونت معنا",
                          style: CustomStyleManger.normalText.copyWith(
                            color: CustomColorsManager.mainTextColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 0),
                        FeatureItem(text: "أسعار معقولة وخدمة سريعة"),
                        FeatureItem(text: "خبراء استشاريون في مجالهم"),
                        FeatureItem(text: "استشارة مجانية"),
                      ],
                    ),
                    SizedBox(height: 10),
                    CustomText(
                      "نقدّم لك أسعارًا وخططًا مثالية ",
                      style: CustomStyleManger.normalText.copyWith(
                        color: CustomColorsManager.mainTextColor,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    BlocBuilder<
                      GetServicesListOfPackagesWithFavCubit,
                      GetServicesListOfPackagesWithFavState
                    >(
                      bloc: getServicesListOfPackagesWithFavCubit,
                      builder: (context, state) {
                        if (state is GetServicesListOfPackagesWithFavLoaded) {
                          return SubscriptionList(packages: state.response.result!);
                        }

                        return CircularProgressIndicator();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  const FeatureItem({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Icon(Icons.check, color: CustomColorsManager.mainTextColor),
        Expanded(
          child: CustomText(
            text.replaceAll(RegExp(r'\n'), ''),
            textAlign: TextAlign.center,
            style: CustomStyleManger.normalText.copyWith(
              color: CustomColorsManager.mainTextColor,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
