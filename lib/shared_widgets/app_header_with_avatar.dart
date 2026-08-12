import 'package:flutter/material.dart';

import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_text.dart';

import '../core/helpers/preferences_manager.dart';

/// App header with avatar (initials), greeting "حياك الله", and client name.
/// Optionally shows a notification bell that navigates or triggers [onNotificationTap].
class AppHeaderWithAvatar extends StatefulWidget {
  const AppHeaderWithAvatar({super.key});

  /// Build initials from name (first 2 letters of first 2 words, uppercase).
  static String getInitials(String name) {
    if (name.trim().isEmpty) return '?';
    final parts = name.trim().split(RegExp(r'\s+'));
    final letters = parts.where((s) => s.isNotEmpty).take(2).map((s) => s[0].toUpperCase()).join();
    return letters.isEmpty ? '?' : letters;
  }

  @override
  State<AppHeaderWithAvatar> createState() => _AppHeaderWithAvatarState();
}

class _AppHeaderWithAvatarState extends State<AppHeaderWithAvatar> {
  String clientName = "";
  void _loadPrefs() async {
    final cName = TpPreferencesManager.retrieveString(TpPreferencesManager.clientName) ?? "";
    if (mounted) setState(() => clientName = cName);
  }

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  @override
  Widget build(BuildContext context) {
    final initial = AppHeaderWithAvatar.getInitials(clientName);
    return Container(
      color: CustomColorsManager.white,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 15, bottom: 15),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: CustomColorsManager.primaryColor,
                  child: Text(
                    initial,
                    style: CustomStyleManger.normalText.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: CustomColorsManager.white,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        'حياك الله',
                        style: CustomStyleManger.normalText.copyWith(
                          fontSize: 14,
                          color: CustomColorsManager.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      CustomText(
                        clientName.isEmpty ? '—' : clientName,
                        style: CustomStyleManger.normalText.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: CustomColorsManager.mainTextColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
