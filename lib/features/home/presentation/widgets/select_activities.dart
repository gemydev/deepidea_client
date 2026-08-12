import 'package:flutter/material.dart';

import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../core/utils/style_manager/style_manager.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../injection_container/injection_container.dart';
import '../cubits/get_list_of_activity/get_list_of_activity_cubit.dart';

class SelectActivities extends StatefulWidget {
  const SelectActivities({super.key});

  @override
  State<SelectActivities> createState() => _SelectActivitiesState();
}

class _SelectActivitiesState extends State<SelectActivities> {
  GetListOfActivityCubit getListOfActivityCubit = sl<GetListOfActivityCubit>();

  @override
  void initState() {
    //  getListOfActivityCubit.getListOfActivity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColorsManager.white,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText("اختر نشاطا", style: CustomStyleManger.heading1.copyWith(fontSize: 20)),
            const SizedBox(height: 15),
            // AccountItem(
            //   imagePath: CustomAssetsManager.people,
            //   title: "العوائل والافراد",
            //   destinationPageName: Routes.familiesActivities,
            // ),
            // Divider(thickness: 0.8, height: 25),
            // AccountItem(
            //   imagePath: CustomAssetsManager.building,
            //   title: "الشركات الصغيرة والمتوسطة",
            //   destinationPageName: Routes.companiesActivities,
            // ),

            // BlocBuilder<GetListOfActivityCubit, GetListOfActivityState>(
            //   bloc: getListOfActivityCubit,
            //   builder: (context, state) {
            //     if (state is GetListOfActivityLoading) {
            //       return const Center(child: CircularProgressIndicator());
            //     } else if (state is GetListOfActivityError) {
            //       return EmptyStateWidget(
            //         message: 'لا توجد أنشطة متاحة',
            //       );
            //     } else if (state is GetListOfActivityLoaded) {
            //       if (state.response.result == null ||
            //           state.response.result!.isEmpty) {
            //         return EmptyStateWidget(
            //           message: state.response.message.toString(),
            //         );
            //       }
            //       return AccountItem(
            //         imagePath: CustomAssetsManager.people,
            //         title: "العوائل والافراد",
            //         destinationPageName: Routes.familiesActivities,
            //       );
            //     }
            //     return const SizedBox.shrink();
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
