import 'package:url_launcher/url_launcher.dart';

import 'snakbar_manager.dart';

/// Support line (WhatsApp / calls), country code without +.
const String kSupportWhatsAppPhone = '966506504866';

/// Same number for [tel:] links and payment forms (E.164 with +).
const String kSupportPhoneE164 = '+966506504866';

Future<bool> _launchExternal(Uri uri) async {
  try {
    return await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (_) {
    return false;
  }
}

Future<void> openSupportWhatsApp({String? prefilledMessage}) async {
  final query = prefilledMessage != null && prefilledMessage.trim().isNotEmpty
      ? '?text=${Uri.encodeComponent(prefilledMessage.trim())}'
      : '';
  final uri = Uri.parse('https://wa.me/$kSupportWhatsAppPhone$query');
  final launched = await _launchExternal(uri);
  if (!launched) {
    AppSnackBar.error('لا يمكن فتح واتساب في الوقت الحالي.');
  }
}

Future<void> launchSupportPhoneCall() async {
  final uri = Uri(scheme: 'tel', path: kSupportPhoneE164);
  final launched = await _launchExternal(uri);
  if (!launched) {
    AppSnackBar.error('لا يمكن إجراء المكالمة الهاتفية في الوقت الحالي.');
  }
}
