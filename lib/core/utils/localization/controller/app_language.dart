import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'locale_storage.dart';

class AppLanguage extends GetxController {
  var appLocale = 'ar';

  @override
  void onInit() async {
    super.onInit();
    LocalStorage localStorage = LocalStorage();
    String? savedLocale = await localStorage.languageSelected;
    appLocale = savedLocale;
    update();
    Get.updateLocale(Locale(appLocale));
  }

  void changeLanguage(String type) async {
    LocalStorage localStorage = LocalStorage();
    if (appLocale == type) {
      return;
    }
    if (type == 'ar') {
      appLocale = 'ar';
      localStorage.saveLanguageToDisk('ar');
    } else {
      appLocale = 'en';
      localStorage.saveLanguageToDisk('en');
    }
    update();
    Get.updateLocale(Locale(appLocale));
  }
}
