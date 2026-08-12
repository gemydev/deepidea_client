import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import 'preferences_manager.dart';

class SenderHelper {
  static const String supportEmail = 'Gooobigtestsup@gmail.com';

  static Future<void> sendInMail() async {
    final String? storeName =
        TpPreferencesManager.retrieveString(TpPreferencesManager.storeName);

    final String htmlBody = """
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
  <meta charset="UTF-8" />
  <title>عرض سعر</title>
</head>
<body style="font-family: Arial, sans-serif; background-color: #f4f4f4; margin:0; padding:0;">
  <div style="max-width:700px; margin:20px auto; background:#fff; padding:20px; border-radius:10px;">
    
    <h2 style="color:#1e8bae; margin-top:0;">مرحبًا $storeName</h2>

    <p style="font-size:16px; color:#333; line-height:1.6;">
      لقد تمت انشاء عرض سعر بناءً على طلبكم رقم <strong>#11234</strong>.
    </p>

    <p style="font-size:16px; color:#333; line-height:1.6;">
      فيما يلي تفاصيل العرض:
    </p>

    <table style="width:100%; border-collapse:collapse; margin-top:15px; font-size:15px;">
      <thead>
        <tr>
          <th style="background:#1e8bae; color:#fff; padding:10px; border:1px solid #ddd;">اسم الخدمة</th>
          <th style="background:#1e8bae; color:#fff; padding:10px; border:1px solid #ddd;">الباقة</th>
          <th style="background:#1e8bae; color:#fff; padding:10px; border:1px solid #ddd;">المدة</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td style="padding:10px; border:1px solid #ddd; text-align:center;">خدمة العوائل والأفراد</td>
          <td style="padding:10px; border:1px solid #ddd; text-align:center;">الباقة الأساسية</td>
          <td style="padding:10px; border:1px solid #ddd; text-align:center;">12 شهر</td>
        </tr>
      </tbody>
    </table>

    <p style="font-size:16px; color:#333; margin-top:20px;">
      فى انتظار ردكم.
    </p>

    <div style="margin-top:20px; background:#1e8bae; color:#fff; padding:10px; text-align:center; border-radius:6px;">
      <p style="margin:0;">لمقترحاتكم وملاحظاتكم راسلونا على: 
        <a href="mailto:info@aap.services" style="color:#fff; text-decoration:underline;">info@aap.services</a>
      </p>
    </div>
  </div>
</body>
</html>
""";

    final Email email = Email(
      body: htmlBody,
      subject: "عرض سعر AAP",
      recipients: [supportEmail],
      isHTML: true,
    );

    try {
      await FlutterEmailSender.send(email);
      debugPrint('✅ Email sent successfully');
    } catch (error) {
      debugPrint('❌ Error sending email: $error');
    }
  }
}
