import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_text.dart';
import 'package:remotely/features/support/presentation/widgets/sub_app_bar.dart';
import 'package:flutter/material.dart';

class WhoWe extends StatefulWidget {
  const WhoWe({super.key});

  @override
  State<WhoWe> createState() => _WhoWeState();
}

class _WhoWeState extends State<WhoWe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColorsManager.scaffoldBGColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SubAppBar(title: "من نحن"),
            SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                child: CustomText(
                  "هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروءلصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجيللنص أو شكل توضع الفقرات في الصفحة التي يقرأها.ولذلك يتم استخدام طريقة لوريم إيبسوم لأنها تعطي توزيعاَطبيعياَ -إلى حد ما- للأحرف عوضاً عن استخدام "
                  " فتجعلها تبدو(أي الأحرف) وكأنها نص مقروء. العديد من برامح النشرالمكتبي وبرامح تحرير صفحات الويب تستخدم لوريم إيبسومبشكل إفتراضي كنموذج عن النص، وإذا قمت بإدخالفي أي محرك بحث ستظهر العديد من المواقع الحديثةالعهد في نتائج البحث. على مدى السنين ظهرت نسخ جديدةومختلفة من نص لوريم إيبسوم، أحياناً عن طريق الصدفة،وأحياناً عن عمد كإدخال بعض العبارات الفكاهية إليها.",
                  style: CustomStyleManger.normalText.copyWith(fontSize: 16),
                  textAlign: TextAlign.start,
                  maxLines: 1000,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
