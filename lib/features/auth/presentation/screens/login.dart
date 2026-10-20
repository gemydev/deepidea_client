import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/data/network/api.dart';
import '../../../../core/helpers/preferences_manager.dart';
import '../../../../core/helpers/snakbar_manager.dart';
import '../../../../core/services/firebase_analytics_service.dart';
import '../../../../core/utils/assets_manager/assets_manager.dart';
import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../core/utils/routes_manager/routes_manager.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_image.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../shared_widgets/labeled_form_field.dart';
import '../../../../injection_container/injection_container.dart';
import '../../data/models/requests/login_request.dart';
import '../cubits/SendOtpVerification/send_otp_verification_cubit.dart';
import '../cubits/login/login_cubit.dart';

// الاستايلات كـ const عشان الـ Text widgets تبقى const وميتعادش بناؤها كل rebuild.
const _kTitleStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: CustomColorsManager.primaryColor,
);
const _kLinkStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.normal,
  color: CustomColorsManager.blueColor,
);
const _kCheckboxLabelStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.normal,
  color: CustomColorsManager.mainTextColor,
);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAnalyticsService _analytics = FirebaseAnalyticsService.instance;

  // ValueNotifier بدل الـ bool + setState: كل واحد بيحرّك الجزء بتاعه بس.
  final _isLoading = ValueNotifier<bool>(false);
  final _isPasswordVisible = ValueNotifier<bool>(false);
  final _saveLoginData = ValueNotifier<bool>(false);

  SendOtpVerificationCubit sendOtpVerificationCubit = sl<SendOtpVerificationCubit>();

  @override
  void initState() {
    super.initState();
    _saveLoginData.value =
        TpPreferencesManager.retrieveBool(TpPreferencesManager.saveLoginData) ?? false;
    final savedEmail = TpPreferencesManager.retrieveString(TpPreferencesManager.savedEmail);
    final savedPass = TpPreferencesManager.retrieveString(TpPreferencesManager.savedPass);
    if (savedEmail != null && savedEmail.isNotEmpty) emailController.text = savedEmail;
    if (savedPass != null && savedPass.isNotEmpty) passwordController.text = savedPass;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _isLoading.dispose();
    _isPasswordVisible.dispose();
    _saveLoginData.dispose();
    super.dispose();
  }

  void _toggleSaveLoginData() {
    final next = !_saveLoginData.value;
    _saveLoginData.value = next;
    TpPreferencesManager.saveBool(TpPreferencesManager.saveLoginData, next);
  }

  Future<void> _handleLogin() async {
    if (_isLoading.value) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;

    await _analytics.logLoginButtonPressed(username: emailController.text.trim());

    if (!mounted) return;
    FocusScope.of(context).unfocus();
    _isLoading.value = true;

    final success = await sl<LoginCubit>().login(
      loginRequest: LoginRequest(
        username: emailController.text.trim(),
        password: passwordController.text,
        lang: "Ar",
        siteID: Api.portalSiteId,
      ),
    );

    _isLoading.value = false;

    if (success == true) {
      await _analytics.logLogin(
        loginMethod: 'email_password',
        username: emailController.text.trim(),
      );

      if (_saveLoginData.value) {
        await TpPreferencesManager.saveString(
          TpPreferencesManager.savedEmail,
          emailController.text.trim(),
        );
        await TpPreferencesManager.saveString(
          TpPreferencesManager.savedPass,
          passwordController.text,
        );
        await TpPreferencesManager.saveBool(TpPreferencesManager.saveLoginData, true);
      } else {
        await TpPreferencesManager.removeData(TpPreferencesManager.savedEmail);
        await TpPreferencesManager.removeData(TpPreferencesManager.savedPass);
        await TpPreferencesManager.saveBool(TpPreferencesManager.saveLoginData, false);
      }

      // sendOtpVerificationCubit.sendOtpVerification(
      //   SendOtpVerificationRequest(
      //     email: TpPreferencesManager.retrieveString(TpPreferencesManager.clientEmail) ?? "",
      //     userId: int.parse(
      //       TpPreferencesManager.retrieveString(TpPreferencesManager.userId) ?? "0",
      //     ),
      //   ),
      // );
      // Get.toNamed(Routes.oTPScreen, arguments: [emailController.text, passwordController.text]);
      Get.toNamed(Routes.baseOfApp);
    } else {
      await _analytics.logLoginFailed(
        username: emailController.text.trim(),
        reason: 'invalid_credentials',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sendOtpVerificationCubit,
      child: BlocListener<SendOtpVerificationCubit, SendOtpVerificationState>(
        bloc: sendOtpVerificationCubit,
        listener: (context, state) {
          if (state is SendOtpVerificationLoaded) {
            AppSnackBar.success(state.response.message);
          }
          if (state is SendOtpVerificationError) {
            AppSnackBar.error(state.message);
          }
        },
        child: Scaffold(
          backgroundColor: CustomColorsManager.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomImage(
                        imagePath: CustomAssetsManager.logoPNG,
                        width: 60,
                        height: 60,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 32),
                      const CustomText("تسجيل الدخول", style: _kTitleStyle),
                      const SizedBox(height: 32),
                      LabeledFormField(
                        label: "البريد الإلكتروني",
                        child: CustomTextFormField(
                          hintText: "أدخل البريد الإلكتروني",
                          controller: emailController,
                          validator: (v) => v == null || v.isEmpty ? "مطلوب" : null,
                        ),
                      ),
                      const SizedBox(height: 24),
                      LabeledFormField(
                        label: "كلمة السر",
                        // بيتبني تاني لوحده بس لما تضغط عين إظهار الباسورد.
                        child: ValueListenableBuilder<bool>(
                          valueListenable: _isPasswordVisible,
                          builder: (context, isVisible, _) {
                            return CustomTextFormField(
                              hintText: "أدخل كلمة السر",
                              controller: passwordController,
                              obscureText: !isVisible,
                              validator: (v) =>
                                  v == null || v.length < 6 ? "كلمة السر قصيرة" : null,
                              onFieldSubmitted: (_) => _handleLogin(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isVisible ? Icons.visibility_off : Icons.visibility,
                                  color: CustomColorsManager.lightTextColor,
                                ),
                                onPressed: () => _isPasswordVisible.value = !isVisible,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: GestureDetector(
                          onTap: () => Get.toNamed(Routes.forgotPassword),
                          child: const CustomText('نسيت كلمة المرور؟', style: _kLinkStyle),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // الـ Checkbox بس اللي بيتبني، والنص جنبه const ثابت.
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: ValueListenableBuilder<bool>(
                              valueListenable: _saveLoginData,
                              builder: (context, saveData, _) {
                                return Checkbox(
                                  value: saveData,
                                  onChanged: (_) => _toggleSaveLoginData(),
                                  activeColor: CustomColorsManager.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: _toggleSaveLoginData,
                            child: const CustomText(
                              "حفظ بيانات الدخول",
                              style: _kCheckboxLabelStyle,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      // الزرار بس اللي بيتبني وقت اللودينج.
                      ValueListenableBuilder<bool>(
                        valueListenable: _isLoading,
                        builder: (context, isLoading, _) {
                          return CustomButton(
                            text: isLoading ? "جاري تسجيل الدخول..." : "تسجيل الدخول",
                            onPressed: isLoading ? null : _handleLogin,
                            backGroundColor: CustomColorsManager.primaryColor,
                            child: isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : null,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
