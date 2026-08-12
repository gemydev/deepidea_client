import 'package:remotely/core/utils/assets_manager/assets_manager.dart';
import 'package:remotely/core/utils/routes_manager/routes_manager.dart';
import 'package:remotely/core/widgets/custom_image.dart';
import 'package:remotely/features/home/presentation/widgets/external_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../core/utils/style_manager/style_manager.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../servicies/presentaion/widgets/empty_state.dart';
import '../cubits/get_all_services_by_web_id/get_all_services_by_web_id_cubit.dart';

class AllServices extends StatefulWidget {
  const AllServices({super.key});

  @override
  State<AllServices> createState() => _AllServicesState();
}

class _AllServicesState extends State<AllServices> {
  final GetAllServicesByWebIdCubit getAllServicesByWebIdCubit = sl<GetAllServicesByWebIdCubit>();

  @override
  void initState() {
    super.initState();
    getAllServicesByWebIdCubit.getAllServicesByWebId();
  }

  @override
  void dispose() {
    getAllServicesByWebIdCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColorsManager.white,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: BlocBuilder<GetAllServicesByWebIdCubit, GetAllServicesByWebIdState>(
          bloc: getAllServicesByWebIdCubit,
          builder: (context, state) {
            if (state is GetAllServicesByWebIdLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GetAllServicesByWebIdError) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _TitleRow(showViewAll: false),
                  SizedBox(height: 15),
                  EmptyStateWidget(message: 'لا توجد خدمات متاحة.'),
                ],
              );
            }

            if (state is GetAllServicesByWebIdLoaded) {
              final services = state.response.result ?? [];
              final bool hasServices = services.isNotEmpty;

              if (!hasServices) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _TitleRow(showViewAll: false),
                    const SizedBox(height: 15),
                    EmptyStateWidget(message: state.response.message ?? 'لا توجد خدمات متاحة.'),
                  ],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _TitleRow(showViewAll: true),
                  const SizedBox(height: 15),
                  ExternalService(
                    withPrice: true,
                    fromAddition: true,
                    withDetailsAndOrderService: true,
                    service: services.first,
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

/// 🔹 Widget خاص بالعنوان + زر "عرض الكل"
class _TitleRow extends StatelessWidget {
  final bool showViewAll;
  const _TitleRow({required this.showViewAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CustomText("كل الخدمات", style: CustomStyleManger.heading1.copyWith(fontSize: 20)),
            const SizedBox(width: 5),
            CustomImage(imagePath: CustomAssetsManager.rocket),
          ],
        ),
        if (showViewAll)
          GestureDetector(
            onTap: () => Get.toNamed(Routes.allServices),
            child: CustomText(
              "عرض الكل",
              style: CustomStyleManger.normalText.copyWith(
                fontSize: 15,
                color: CustomColorsManager.lightTextColor,
              ),
            ),
          ),
      ],
    );
  }
}
