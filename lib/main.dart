import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'core/navigation/app_route_observer.dart';
import 'core/constants/ui.dart';
import 'core/helpers/preferences_manager.dart';
import 'core/localization/controller/app_language.dart';
import 'core/localization/translation.dart';
import 'core/services/edfa_payment_service.dart.dart';
import 'core/utils/color_manager/color_manager.dart';
import 'core/utils/functions/set_local.dart';
import 'core/utils/routes_manager/routes_manager.dart';
import 'features/call_feature/call_manager.dart';
import 'firebase_options.dart';
import 'injection_container/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with platform-specific options
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Enable Analytics debug mode in debug builds
  if (kDebugMode) {
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  }
  await initializeDateFormatting('ar', null);
  await GetStorage.init();
  await init();
  Get.put(AppLanguage());
  EdfaPaymentService.instance.initialize();
  await CallManager.setupEngine();
  await CallManager.initFromPreferences();

  AppLanguage().onInit();
  setLocal();

  // Status bar: white background, dark icons
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final loggedIn = TpPreferencesManager.retrieveBool(TpPreferencesManager.isLoggedIn) ?? false;

    return GetMaterialApp(
      navigatorKey: CallManager.navigatorKey,
      navigatorObservers: [appRouteObserver],
      builder: (context, child) {
        return ResponsiveBreakpoints.builder(
          breakpoints: [
            const Breakpoint(start: 0, end: 480, name: MOBILE),
            const Breakpoint(start: 481, end: 1200, name: TABLET),
            const Breakpoint(start: 1201, end: double.infinity, name: DESKTOP),
          ],
          child: child!,
        );
      },
      color: CustomColorsManager.primaryColor,
      title: 'DeepIdea',
      debugShowCheckedModeBanner: false,
      translations: Translation(),
      locale: Locale(defaultLocale),
      fallbackLocale: const Locale('ar'),
      getPages: Routes.routes,
      initialRoute: loggedIn ? Routes.baseOfApp : Routes.splashScreen,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: CustomColorsManager.scaffoldBGColor,
        fontFamily: GoogleFonts.ibmPlexSansArabic().fontFamily ?? 'IBM Plex Sans Arabic',
        textTheme: GoogleFonts.ibmPlexSansArabicTextTheme(),
      ),
    );
  }
}
