import 'package:flutter/material.dart';

import '../../../../core/utils/style_manager/style_manager.dart';
import '../../../../core/widgets/custom_text.dart';
import '../screens/orders_follow.dart';

class OrderDetailsHeader extends StatelessWidget {
  const OrderDetailsHeader({
    super.key,
    required this.status,
    this.isCurrent = false,
  });

  final String status;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          isCurrent ? "تفاصيل الطلب الحالي" : 'تفاصيل الطلب',
          style: CustomStyleManger.heading1.copyWith(fontSize: 15),
        ),
        StatusContainer(title: status),
      ],
    );
  }
}
