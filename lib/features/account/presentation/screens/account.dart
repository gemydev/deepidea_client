// lib/features/account/presentation/screens/account_screen.dart

import 'package:remotely/core/helpers/snakbar_manager.dart';
import 'package:remotely/core/helpers/whatsapp_launcher.dart';
import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/formatter/date_format.dart';
import 'package:remotely/core/utils/routes_manager/routes_manager.dart';
import 'package:remotely/features/auth/presentation/cubits/logout/logout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/preferences_manager.dart';
import '../../../../core/navigation/route_resume_refresh_mixin.dart';
import '../../../call_feature/call_manager.dart';
import '../../../../injection_container/account/account_injection.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../../shared_widgets/app_header_with_avatar.dart';
import '../../../../shared_widgets/logout_confirmation_dialog.dart';
import '../cubits/client_subscription_status/client_subscription_status_cubit.dart';
import '../widgets/account_profile_design.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> with RouteResumeRefreshMixin {
  late final ClientSubscriptionStatusCubit _subscriptionCubit;

  String? clientName;
  String _email = '';
  String _phone = '';
  String _address = '';
  String _company = '';
  String _userId = '';
  String _rawUserId = '';
  bool _isLoggingOut = false;

  @override
  void initState() {
    super.initState();
    accountInit(sl);
    _subscriptionCubit = sl<ClientSubscriptionStatusCubit>();
    _loadPrefs();
  }

  @override
  void refreshWhenRouteResumed() {
    _loadPrefs();
  }

  @override
  void dispose() {
    _subscriptionCubit.close();
    super.dispose();
  }

  void _loadPrefs() async {
    final cName = TpPreferencesManager.retrieveString(TpPreferencesManager.clientName);
    final email = TpPreferencesManager.retrieveString(TpPreferencesManager.clientEmail) ?? '';
    final phone = TpPreferencesManager.retrieveString(TpPreferencesManager.clientPhone) ?? '';
    final address = TpPreferencesManager.retrieveString(TpPreferencesManager.clientAddress) ?? '';
    final company = TpPreferencesManager.retrieveString(TpPreferencesManager.storeName) ?? '';
    final uid = TpPreferencesManager.retrieveString(TpPreferencesManager.userId) ?? '';

    setState(() {
      clientName = cName;
      _email = email;
      _phone = phone;
      _address = address.isNotEmpty ? address : 'الرياض، السعودية';
      _company = company.isNotEmpty ? company : 'شركة 360 remotely';
      _rawUserId = uid;
      _userId = uid.isNotEmpty ? '#$uid' : '#—';
    });

    if (uid.isNotEmpty) {
      _subscriptionCubit.load(uid);
    }
  }

  void _handleLogout() async {
    if (_isLoggingOut) return;

    // Nothing happens until the user explicitly confirms.
    final confirmed = await showLogoutConfirmationDialog();
    if (!confirmed || !mounted) return;

    setState(() {
      _isLoggingOut = true;
    });

    final success = await sl<LogoutCubit>().logout();
    if (success) {
      CallManager.uninit();
      Get.offAllNamed(Routes.login);
      AppSnackBar.success('تم تسجيل الخروج بنجاح.');
      TpPreferencesManager.clearAllData();
      TpPreferencesManager.saveBool(TpPreferencesManager.isLoggedIn, false);
      return;
    }

    AppSnackBar.error('حدث خطأ أثناء تسجيل الخروج.');
    if (!mounted) return;
    setState(() {
      _isLoggingOut = false;
    });
  }

  Future<void> _openRenewWhatsApp() async {
    final name = clientName ?? '';
    final message = 'مرحباً، أود تجديد اشتراك الباقة${name.isNotEmpty ? ' — $name' : ''}';
    await openSupportWhatsApp(prefilledMessage: message);
  }

  @override
  Widget build(BuildContext context) {
    final name = clientName ?? '';
    final planFallbackName = _company.isNotEmpty
        ? _company
        : (name.isNotEmpty ? name : 'خطة الاشتراك');

    return BlocProvider.value(
      value: _subscriptionCubit,
      child: BlocConsumer<ClientSubscriptionStatusCubit, ClientSubscriptionStatusState>(
        listener: (context, state) {
          if (state is ClientSubscriptionStatusError) {
            AppSnackBar.error(state.message);
          }
        },
        builder: (context, subscriptionState) {
          var planName = planFallbackName;
          var planStatusLabel = '—';
          var subscriptionDateLabel = '—';
          var renewalDateLabel = '—';
          var isSubscriptionActive = true;
          var showRenewButton = false;
          var isPlanLoading =
              subscriptionState is ClientSubscriptionStatusLoading ||
              subscriptionState is ClientSubscriptionStatusInitial;

          if (subscriptionState is ClientSubscriptionStatusLoaded) {
            final sub = subscriptionState.response;
            planName = planFallbackName;
            planStatusLabel = sub.statusMessage ?? '—';
            subscriptionDateLabel = formatArabicDate(sub.subscriptionStartDate);
            renewalDateLabel = formatArabicDate(sub.subscriptionEndDate);
            isSubscriptionActive = sub.isSubscriptionActive;
            showRenewButton = !sub.isSubscriptionActive;
            isPlanLoading = false;
          } else if (_rawUserId.isEmpty) {
            isPlanLoading = false;
          }

          return SafeArea(
            child: ColoredBox(
              color: CustomColorsManager.scaffoldBGColor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const AppHeaderWithAvatar(),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AccountProfileDesign(
                        clientName: name,
                        email: _email.isNotEmpty ? _email : '—',
                        phone: _phone.isNotEmpty ? _phone : '—',
                        address: _address,
                        company: _company,
                        customerIdLabel: _userId,
                        planName: planName,
                        planStatusLabel: planStatusLabel.isNotEmpty ? planStatusLabel : '—',
                        subscriptionDateLabel: subscriptionDateLabel.isNotEmpty
                            ? subscriptionDateLabel
                            : '—',
                        renewalDateLabel: renewalDateLabel.isNotEmpty ? renewalDateLabel : '—',
                        isSubscriptionActive: isSubscriptionActive,
                        showRenewButton: showRenewButton,
                        isPlanLoading: isPlanLoading,
                        onRenewPackage: _openRenewWhatsApp,
                        onLogout: _handleLogout,
                        isLoggingOut: _isLoggingOut,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
