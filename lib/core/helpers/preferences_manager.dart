import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../injection_container/injection_container.dart';

class TpPreferencesManager {
  static SharedPreferences prefs = sl<SharedPreferences>();

  static String authKey = "authKey";
  static String userId = "userId";
  static String websiteId = "tpWebsiteId";
  static String clientEmail = "clientEmail";
  static String clientPhone = "clientPhone";
  static String clientName = "clientName";
  static String clientAddress = "clientAddress";
  static String storeName = "storeName";
  static String tpSoftPosAuthCode = "tpSoftPosAuthCode";
  static String edfaPluginInitiated = "edfaPluginInitiated";
  static String isLoggedIn = "isLoggedIn";
  static String supportChatOpend = "supportChatOpend";
  static String supporterFullName = "supporterFullName";
  static String supporterId = "supporterId";
  static String savedPass = "savedPass";
  static String savedEmail = "savedEmail";
  static String hasSeenOnboarding = "hasSeenOnboarding";
  static String saveLoginData = "saveLoginData";

  static Future<void> saveString(key, value) async {
    await prefs.setString(key, value);
    debugPrint('saved $key : $value');
  }

  static Future<void> saveInt(key, value) async {
    await prefs.setInt(key, value);
    debugPrint('saved $key : $value');
  }

  static Future<void> saveDouble(key, value) async {
    await prefs.setDouble(key, value);
    debugPrint('saved $key : $value');
  }

  static Future<void> saveStringList(key, value) async {
    await prefs.setStringList(key, value);
    debugPrint('saved $key : $value');
  }

  static Future<void> saveBool(key, value) async {
    await prefs.setBool(key, value);
    debugPrint('saved $key : $value');
  }

  static String? retrieveString(key) {
    String? result = prefs.getString(key);
    debugPrint('retrieve $key : $result');
    return result;
  }

  static int? retrieveInt(key) {
    int? result = prefs.getInt(key);
    debugPrint('retrieve $key : $result');
    return result;
  }

  static double? retrieveDouble(key) {
    double? result = prefs.getDouble(key);
    debugPrint('retrieve $key : $result');
    return result;
  }

  static List<String>? retrieveStringList(key) {
    List<String>? result = prefs.getStringList(key);
    debugPrint('retrieve $key : $result');
    return result;
  }

  static bool? retrieveBool(key) {
    bool? result = prefs.getBool(key);
    return result;
  }

  static Future<void> removeData(key) async {
    await prefs.remove(key);
    debugPrint('removeData $key');
  }

  /// ✅ Remove all data from SharedPreferences
  static Future<void> clearAllData() async {
    // احفظ القيم اللي عايزين نحتفظ بيها
    final savedPassword = prefs.getString(savedPass);
    final savedUserEmail = prefs.getString(savedEmail);

    // مسح كل البيانات
    await prefs.clear();

    // ارجع القيم اللي عايزين نحتفظ بيها
    if (savedPassword != null) {
      await prefs.setString(savedPass, savedPassword);
    }
    if (savedUserEmail != null) {
      await prefs.setString(savedEmail, savedUserEmail);
    }

    debugPrint(
      '✅ All SharedPreferences data cleared except savedPass & savedEmail',
    );
  }
}
