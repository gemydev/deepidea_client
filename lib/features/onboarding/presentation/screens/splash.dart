import 'package:remotely/core/helpers/preferences_manager.dart';
import 'package:remotely/core/utils/assets_manager/assets_manager.dart';
import 'package:remotely/core/utils/routes_manager/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(
      const Duration(seconds: 2),
      () {
        final hasSeen = TpPreferencesManager.retrieveBool(TpPreferencesManager.hasSeenOnboarding) ?? false;
        if (hasSeen) {
          Get.offNamed(Routes.login);
        } else {
          Get.offNamed(Routes.onboardingScreen);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset(CustomAssetsManager.logoPNG)),
    );
  }
}
