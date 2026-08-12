import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../core/helpers/subscription_expiry_reminder.dart';
import '../core/navigation/base_shell_navigation_controller.dart';
import '../features/call_feature/call_manager.dart';
import '../core/utils/assets_manager/assets_manager.dart';
import '../core/utils/color_manager/color_manager.dart';
import 'account/presentation/screens/account.dart';
import 'home/presentation/screens/home.dart';
import 'support/presentation/screens/orders_follow.dart';
import 'support/presentation/screens/support.dart';

class BaseOfApp extends StatefulWidget {
  const BaseOfApp({super.key});

  @override
  State<BaseOfApp> createState() => _BaseOfAppState();
}

class _BaseOfAppState extends State<BaseOfApp> with WidgetsBindingObserver {
  late final BaseShellNavigationController _shellNav;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _shellNav = Get.put(BaseShellNavigationController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CallManager.enterAcceptedOfflineCallIfNeeded();
      checkAndShowSubscriptionExpiryReminder();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      checkAndShowSubscriptionExpiryReminder();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (Get.isRegistered<BaseShellNavigationController>()) {
      Get.delete<BaseShellNavigationController>();
    }
    super.dispose();
  }

  Widget _bodyForIndex(int index) {
    switch (index) {
      case 0:
        return const HomeScreen(complete: true);
      case 1:
        return TicketOrdersFollow(
          key: ValueKey<String>(
            'tickets_${_shellNav.ticketOrdersFilterStatusId.value ?? 'all'}',
          ),
        );
      case 2:
        return const SupportScreen();
      case 3:
        return const AccountScreen();
      default:
        return const HomeScreen(complete: true);
    }
  }

  Widget _navIcon(String assetPath, Color color, {double size = 24}) {
    return SvgPicture.asset(
      assetPath,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: _bodyForIndex(_shellNav.selectedPageIndex.value),
        backgroundColor: CustomColorsManager.scaffoldBGColor,
        bottomNavigationBar: StylishBottomBar(
        option: BubbleBarOptions(
          barStyle: BubbleBarStyle.horizontal,
          bubbleFillStyle: BubbleFillStyle.fill,
          opacity: 0.3,
        ),
        backgroundColor: CustomColorsManager.white,
        currentIndex: _shellNav.selectedPageIndex.value,
        onTap: (index) {
          if (index == 1) {
            _shellNav.ticketOrdersFilterStatusId.value = null;
          }
          _shellNav.selectedPageIndex.value = index;
        },
        items: [
          BottomBarItem(
            icon: _navIcon(CustomAssetsManager.navHome, CustomColorsManager.unSelectedBorderColor),
            selectedIcon: _navIcon(CustomAssetsManager.navHome, CustomColorsManager.primaryColor),
            title: const Text('الرئيسية'),
            backgroundColor: CustomColorsManager.primaryColor,
            selectedColor: CustomColorsManager.primaryColor,
            unSelectedColor: CustomColorsManager.unSelectedBorderColor,
          ),
          BottomBarItem(
            icon: _navIcon(
              CustomAssetsManager.navTickets,
              CustomColorsManager.unSelectedBorderColor,
            ),
            selectedIcon: _navIcon(
              CustomAssetsManager.navTickets,
              CustomColorsManager.primaryColor,
            ),
            title: const Text('التذاكر'),
            backgroundColor: CustomColorsManager.primaryColor,
            selectedColor: CustomColorsManager.primaryColor,
            unSelectedColor: CustomColorsManager.unSelectedBorderColor,
          ),
          BottomBarItem(
            icon: _navIcon(
              CustomAssetsManager.navContact,
              CustomColorsManager.unSelectedBorderColor,
            ),
            selectedIcon: _navIcon(
              CustomAssetsManager.navContact,
              CustomColorsManager.primaryColor,
            ),
            title: const Text('التواصل'),
            backgroundColor: CustomColorsManager.primaryColor,
            selectedColor: CustomColorsManager.primaryColor,
            unSelectedColor: CustomColorsManager.unSelectedBorderColor,
          ),
          BottomBarItem(
            icon: _navIcon(
              CustomAssetsManager.navMyProfile,
              CustomColorsManager.unSelectedBorderColor,
            ),
            selectedIcon: _navIcon(
              CustomAssetsManager.navMyProfile,
              CustomColorsManager.primaryColor,
            ),
            title: const Text('حسابي'),
            backgroundColor: CustomColorsManager.primaryColor,
            selectedColor: CustomColorsManager.primaryColor,
            unSelectedColor: CustomColorsManager.unSelectedBorderColor,
          ),
        ],
        ),
      ),
    );
  }
}
