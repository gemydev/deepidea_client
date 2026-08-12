import 'package:remotely/features/progress/presentation/widgets/service_progress_item.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/style_manager/style_manager.dart';
import '../../../../core/widgets/custom_text.dart';

class ServiceProgress extends StatelessWidget {
  const ServiceProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: CustomText(
            "تقدم الخدمات",
            style: CustomStyleManger.heading1.copyWith(fontSize: 20),
          ),
        ),
        const ServiceProgressItem(),
        const ServiceProgressItem(),
      ],
    );
  }
}
