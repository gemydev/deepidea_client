import 'package:remotely/core/helpers/subscription_guard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/data/network/dio_client.dart';
import '../../../../../core/helpers/preferences_manager.dart';
import '../../../../../core/helpers/snakbar_manager.dart';
import '../../../../../core/utils/assets_manager/assets_manager.dart';
import '../../../../../core/utils/color_manager/color_manager.dart';
import '../../../../../injection_container/injection_container.dart';
import '../../../../../shared_widgets/section_title.dart';
import '../../../../../shared_widgets/support_contact_tile.dart';
import '../../../../call_feature/call_manager.dart';
import '../../../../call_feature/data/call_service.dart';
import '../../../../call_feature/data/models/responses/available_supporter.dart';
import '../../../../chat/screens/chat_screen.dart';

class ContactUsColumn extends StatelessWidget {
  const ContactUsColumn({super.key});

  Future<void> _withAvailableSupporter(
    Future<void> Function(AvailableSupportResponse supporter) action,
  ) async {
    if (!await ensureActiveSubscription()) return;
    try {
      final supporter =
          await CallApiService(sl<NetworkClient>()).getAvailableSupporter();
      if (supporter.autoId <= 0) {
        AppSnackBar.error('لا يوجد مختص دعم متاح حالياً.');
        return;
      }
      await action(supporter);
    } catch (_) {
      // Errors are surfaced by [CallApiService] (snackbar).
    }
  }

  int? _currentUserId() {
    final raw =
        TpPreferencesManager.retrieveString(TpPreferencesManager.userId);
    if (raw == null || raw.trim().isEmpty) {
      return null;
    }
    return int.tryParse(raw.trim());
  }

  void _openChat() {
    final userId = _currentUserId();
    if (userId == null) {
      AppSnackBar.error('تعذر تحديد حسابك. أعد تسجيل الدخول.');
      return;
    }

    _withAvailableSupporter((availableSupporter) async {
      Get.to(
        ChatScreen(
          userId: userId,
          receiverId: availableSupporter.autoId,
          clientName: availableSupporter.fullName,
        ),
      );
    });
  }

  void _openVoiceCall() {
    _withAvailableSupporter((availableSupporter) async {
      await CallManager.sendCallInvitation(
        calleeID: availableSupporter.autoId.toString(),
        calleeName: availableSupporter.fullName,
        isVideo: false,
      );
    });
  }

  void _openVideoCall() {
    _withAvailableSupporter((availableSupporter) async {
      await CallManager.sendCallInvitation(
        calleeID: availableSupporter.autoId.toString(),
        calleeName: availableSupporter.fullName,
        isVideo: true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle('تواصل معنا'),
        const SizedBox(height: 17),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SupportContactTile(
                iconPath: CustomAssetsManager.messagesNew,
                title: 'تواصل نصي',
                subtitle: 'دردشة فورية مع خدمة العملاء',
                showShadow: false,
                subtitleColor: CustomColorsManager.black,
                onTap: _openChat,
              ),
              const SizedBox(height: 10),
              SupportContactTile(
                iconPath: CustomAssetsManager.callCallingNew,
                title: 'تواصل صوتي',
                subtitle: 'تحدث مباشرة مع المختص',
                showShadow: false,
                subtitleColor: CustomColorsManager.black,
                onTap: _openVoiceCall,
              ),
              const SizedBox(height: 10),
              SupportContactTile(
                iconPath: CustomAssetsManager.batteryEmpty,
                title: 'تواصل فيديو',
                subtitle: 'مقابلة مرئية للدعم الفني',
                showShadow: false,
                subtitleColor: CustomColorsManager.black,
                onTap: _openVideoCall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
