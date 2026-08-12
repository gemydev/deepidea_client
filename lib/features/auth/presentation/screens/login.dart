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
import '../../../../core/utils/style_manager/style_manager.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_image.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../shared_widgets/labeled_form_field.dart';
import '../../../../injection_container/injection_container.dart';
import '../../data/models/requests/login_request.dart';
import '../cubits/SendOtpVerification/send_otp_verification_cubit.dart';
import '../cubits/login/login_cubit.dart';

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
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _saveLoginData = false;

  SendOtpVerificationCubit sendOtpVerificationCubit = sl<SendOtpVerificationCubit>();

  @override
  void initState() {
    super.initState();
    _saveLoginData = TpPreferencesManager.retrieveBool(TpPreferencesManager.saveLoginData) ?? false;
    final savedEmail = TpPreferencesManager.retrieveString(TpPreferencesManager.savedEmail);
    final savedPass = TpPreferencesManager.retrieveString(TpPreferencesManager.savedPass);
    if (savedEmail != null && savedEmail.isNotEmpty) emailController.text = savedEmail;
    if (savedPass != null && savedPass.isNotEmpty) passwordController.text = savedPass;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_isLoading) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;

    await _analytics.logLoginButtonPressed(username: emailController.text.trim());

    if (!mounted) return;
    FocusScope.of(context).unfocus();
    setState(() => _isLoading = true);

    final success = await sl<LoginCubit>().login(
      loginRequest: LoginRequest(
        username: emailController.text.trim(),
        password: passwordController.text,
        lang: "Ar",
        siteID: Api.portalSiteId,
      ),
    );

    setState(() => _isLoading = false);

    if (success == true) {
      await _analytics.logLogin(
        loginMethod: 'email_password',
        username: emailController.text.trim(),
      );

      if (_saveLoginData) {
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
                      CustomImage(
                        imagePath: CustomAssetsManager.logoPNG,
                        width: 60,
                        height: 60,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 32),
                      CustomText(
                        "تسجيل الدخول",
                        style: CustomStyleManger.heading1.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: CustomColorsManager.primaryColor,
                        ),
                      ),
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
                        child: CustomTextFormField(
                          hintText: "أدخل كلمة السر",
                          controller: passwordController,
                          obscureText: !_isPasswordVisible,
                          validator: (v) => v == null || v.length < 6 ? "كلمة السر قصيرة" : null,
                          onFieldSubmitted: (_) => _handleLogin(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                              color: CustomColorsManager.lightTextColor,
                            ),
                            onPressed: () {
                              setState(() => _isPasswordVisible = !_isPasswordVisible);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: GestureDetector(
                          onTap: () => Get.toNamed(Routes.forgotPassword),
                          child: CustomText(
                            'نسيت كلمة المرور؟',
                            style: CustomStyleManger.normalText.copyWith(
                              fontSize: 15,
                              color: CustomColorsManager.blueColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Checkbox(
                              value: _saveLoginData,
                              onChanged: (v) {
                                setState(() => _saveLoginData = v ?? true);
                                TpPreferencesManager.saveBool(
                                  TpPreferencesManager.saveLoginData,
                                  v ?? true,
                                );
                              },
                              activeColor: CustomColorsManager.primaryColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              setState(() => _saveLoginData = !_saveLoginData);
                              TpPreferencesManager.saveBool(
                                TpPreferencesManager.saveLoginData,
                                !_saveLoginData,
                              );
                            },
                            child: CustomText(
                              "حفظ بيانات الدخول",
                              style: CustomStyleManger.normalText.copyWith(
                                fontSize: 15,
                                color: CustomColorsManager.mainTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      CustomButton(
                        text: _isLoading ? "جاري تسجيل الدخول..." : "تسجيل الدخول",
                        onPressed: _isLoading ? null : _handleLogin,
                        backGroundColor: CustomColorsManager.primaryColor,
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : null,
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
