import 'package:intl/intl.dart';

String formatArabicDate(String? dateTimeStr) {
  if (dateTimeStr == null || dateTimeStr.isEmpty) return '';
  try {
    final date = DateTime.parse(dateTimeStr);
    final formatter = DateFormat('d MMMM yyyy', 'ar');
    return formatter.format(date);
  } catch (e) {
    return dateTimeStr;
  }
}

String getTodayNameInArabic() {
  final now = DateTime.now();
  const daysInArabic = [
    'الاثنين', // Monday
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
    'الأحد',
  ];

  // DateTime.weekday: Monday = 1, Sunday = 7
  return daysInArabic[now.weekday - 1];
}

/// Date + time, e.g. "12 مايو 2025 - 03:45 م".
String formatArabicDateTime(String? dateTimeStr) {
  if (dateTimeStr == null || dateTimeStr.isEmpty) return '';
  try {
    final date = DateTime.parse(dateTimeStr).toLocal();
    return DateFormat('d MMMM yyyy - hh:mm a', 'ar').format(date);
  } catch (e) {
    return dateTimeStr;
  }
}
