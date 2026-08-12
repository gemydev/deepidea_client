import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:remotely/core/config/zego_config.dart';
import 'package:remotely/core/helpers/preferences_manager.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class CallManager {
  static int get appID => ZegoConfig.appID;
  static String get appSign => ZegoConfig.appSign;

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static bool _inviteInProgress = false;
  static DateTime? _lastInviteAt;
  static const Duration _inviteCooldown = Duration(seconds: 2);

  /// Call once from [main] before [runApp] (system calling UI + navigator key).
  static Future<void> setupEngine() async {
    ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
    await ZegoUIKit().initLog();
    await ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );
  }

  /// After login or when restoring a logged-in session on cold start.
  static Future<void> initFromPreferences() async {
    final userID =
        TpPreferencesManager.retrieveString(TpPreferencesManager.userId);
    if (userID == null || userID.isEmpty) return;

    final authKey =
        TpPreferencesManager.retrieveString(TpPreferencesManager.authKey);
    if (authKey == null || authKey.isEmpty) return;

    final userName =
        TpPreferencesManager.retrieveString(TpPreferencesManager.clientName) ??
            'User';

    await init(userID: userID, userName: userName);
  }

  static Future<void> init({
    required String userID,
    required String userName,
  }) async {
    log('Zego init — userId: $userID, userName: $userName');

    final service = ZegoUIKitPrebuiltCallInvitationService();
    if (service.isInit) {
      uninit();
    }

    await service.init(
      appID: appID,
      appSign: appSign,
      userID: userID,
      userName: userName,
      plugins: [ZegoUIKitSignalingPlugin()],
      requireConfig: (data) {
        return data.type == ZegoCallInvitationType.videoCall
            ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
            : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();
      },
      notificationConfig: ZegoCallInvitationNotificationConfig(
        androidNotificationConfig: ZegoCallAndroidNotificationConfig(),
        iOSNotificationConfig: ZegoCallIOSNotificationConfig(
          certificateIndex:
              ZegoSignalingPluginMultiCertificate.firstCertificate,
          appName: 'Remotely360',
        ),
      ),
    );
  }

  static void uninit() {
    ZegoUIKitPrebuiltCallInvitationService().uninit();
  }

  /// Call when the main shell is ready (offline accepted calls).
  static void enterAcceptedOfflineCallIfNeeded() {
    ZegoUIKitPrebuiltCallInvitationService().enterAcceptedOfflineCall();
  }

  static Future<void> sendCallInvitation({
    required String calleeID,
    required String calleeName,
    bool isVideo = true,
  }) async {
    final now = DateTime.now();
    if (_inviteInProgress ||
        (_lastInviteAt != null &&
            now.difference(_lastInviteAt!) < _inviteCooldown)) {
      debugPrint('Call invitation skipped (already in progress or cooldown)');
      return;
    }

    final service = ZegoUIKitPrebuiltCallInvitationService();
    if (!service.isInit) {
      debugPrint('Call service not initialized — initializing from preferences');
      await initFromPreferences();
    }
    if (!service.isInit) {
      debugPrint('Call service still not initialized after retry');
      return;
    }

    if (calleeID.isEmpty || calleeID == '0') {
      debugPrint('Call invitation skipped — invalid callee id');
      return;
    }

    final callerName =
        TpPreferencesManager.retrieveString(TpPreferencesManager.clientName) ??
            'User';

    _inviteInProgress = true;
    _lastInviteAt = now;
    try {
      await service.send(
        invitees: [ZegoCallUser(calleeID, calleeName)],
        isVideoCall: isVideo,
        resourceID: ZegoConfig.callInvitationResourceId,
        notificationTitle: 'Incoming Call',
        notificationMessage: isVideo
            ? 'Video call from $callerName'
            : 'Voice call from $callerName',
        timeoutSeconds: 60,
      );
    } finally {
      _inviteInProgress = false;
    }
  }

  static Widget videoCallPage({
    required String callID,
    required String userID,
    required String userName,
  }) {
    return ZegoUIKitPrebuiltCall(
      appID: appID,
      appSign: appSign,
      userID: userID,
      userName: userName,
      callID: callID,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }

  static Widget audioCallPage({
    required String callID,
    required String userID,
    required String userName,
  }) {
    return ZegoUIKitPrebuiltCall(
      appID: appID,
      appSign: appSign,
      userID: userID,
      userName: userName,
      callID: callID,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
    );
  }
}
