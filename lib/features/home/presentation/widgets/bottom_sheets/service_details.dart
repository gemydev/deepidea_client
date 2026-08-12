import 'package:remotely/features/home/data/models/requests/get_service_from_service_id.dart';
import 'package:remotely/features/home/data/models/responses/get_service_from_service_id.dart';
import 'package:remotely/features/home/presentation/cubits/get_service_from_service_id/get_service_from_service_id_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/assets_manager/assets_manager.dart';
import '../../../../../core/utils/color_manager/color_manager.dart';
import '../../../../../core/utils/style_manager/style_manager.dart';
import '../../../../../core/widgets/custom_image.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../injection_container/injection_container.dart';

/// ------------------------------------------------------------
/// Bottom Sheet (ENTRY POINT)
/// ------------------------------------------------------------
void showServiceDetailsBottomSheet(BuildContext context, GetServiceFromServiceIdRequest request) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
    ),
    builder: (_) {
      return BlocProvider<GetServiceFromServiceIdCubit>(
        create: (_) => sl<GetServiceFromServiceIdCubit>()..getServiceFromServiceId(request),
        child: const _ServiceDetailsBottomSheet(),
      );
    },
  );
}

/// ------------------------------------------------------------
/// Bottom Sheet Content
/// ------------------------------------------------------------
class _ServiceDetailsBottomSheet extends StatelessWidget {
  const _ServiceDetailsBottomSheet();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetServiceFromServiceIdCubit, GetServiceFromServiceIdState>(
      builder: (context, state) {
        if (state is GetServiceFromServiceIdLoading) {
          return SizedBox(
            height: 300,
            child: const Padding(
              padding: EdgeInsets.all(40),
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        if (state is GetServiceFromServiceIdError) {
          return Padding(
            padding: const EdgeInsets.all(40),
            child: Center(child: CustomText(state.message, style: CustomStyleManger.normalText)),
          );
        }

        if (state is GetServiceFromServiceIdLoaded) {
          return _ServiceDetailsUI(service: state.response.result);
        }

        return const SizedBox();
      },
    );
  }
}

/// ------------------------------------------------------------
/// UI (PURE – uses API response only)
/// ------------------------------------------------------------
class _ServiceDetailsUI extends StatelessWidget {
  const _ServiceDetailsUI({required this.service});

  final ServiceResult? service;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText('تفاصيل الخدمة', style: CustomStyleManger.heading1.copyWith(fontSize: 15)),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close_rounded),
              ),
            ],
          ),

          const SizedBox(height: 15),

          /// Image
          const CustomImage(
            imagePath: CustomAssetsManager.test,
            width: double.infinity,
            height: 220,
            fit: BoxFit.fill,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Package name
                CustomText(
                  service?.packageName ?? '',
                  style: CustomStyleManger.heading1.copyWith(fontSize: 16),
                ),

                const SizedBox(height: 15),
                _divider(),

                _detailRow("الكمية المستخدمة", service?.usedQty, service?.unit),
                _detailRow("الكمية المتاحة", service?.availableQty, service?.unit),
                _detailRow("سعر الوحدة", service?.unitPrice, "ريال"),
                _detailRow("مدة التنفيذ", service?.executionTime, "يوم"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ----------------------------------------------------------
  /// Helpers
  /// ----------------------------------------------------------
  Widget _detailRow(String title, num? value, String? unit) {
    final displayValue = value != null
        ? "$value${unit != null && unit.isNotEmpty ? " $unit" : ""}"
        : "-";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(title, style: CustomStyleManger.normalText.copyWith(fontSize: 17)),
          CustomText(displayValue, style: CustomStyleManger.normalText.copyWith(fontSize: 17)),
        ],
      ),
    );
  }

  Divider _divider() {
    return Divider(color: CustomColorsManager.lightTextColor.withValues(alpha: 0.3), thickness: 1);
  }
}
