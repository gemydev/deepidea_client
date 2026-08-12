import 'package:flutter/material.dart';

import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_text.dart';
import 'package:remotely/shared_widgets/shadow_card.dart';
import 'package:remotely/shared_widgets/status_chip.dart';

/// A card displaying a ticket/conversation: status chip, title, optional tag, and body preview.
class TicketListCard extends StatelessWidget {
  const TicketListCard({
    super.key,
    required this.title,
    required this.statusLabel,
    required this.statusColor,
    this.tagLabel,
    this.bodyPreview,
    this.onTap,
  });

  final String title;
  final String statusLabel;
  final Color statusColor;
  final String? tagLabel;
  final String? bodyPreview;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ShadowCard(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatusChip(label: statusLabel, color: statusColor),
            const SizedBox(height: 10),
            CustomText(
              title,
              style: CustomStyleManger.heading1.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: CustomColorsManager.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (tagLabel != null && tagLabel!.isNotEmpty) ...[
              const SizedBox(height: 4),
              CustomText(
                tagLabel!,
                style: CustomStyleManger.normalText.copyWith(
                  fontSize: 12,
                  color: CustomColorsManager.lightTextColor,
                ),
              ),
            ],
            if (bodyPreview != null && bodyPreview!.isNotEmpty) ...[
              const SizedBox(height: 4),
              CustomText(
                bodyPreview!,
                style: CustomStyleManger.normalText.copyWith(
                  fontSize: 13,
                  color: CustomColorsManager.lightTextColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
