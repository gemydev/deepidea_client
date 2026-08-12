/// ZEGOCLOUD Console → Project → App credentials.
/// Resource ID must match the ID created in Console (VoIP / FCM) for call invitations.
abstract final class ZegoConfig {
  static const int appID = 1288454377;

  static const String appSign =
      '372855543fee9283255ee2085c12f9945ba5cbdb4f25356c7196583820adb784';

  /// Must match ZEGO Console → Projects → Your project → Call invitation → Resource ID.
  static const String callInvitationResourceId = 'zego_call';
}
