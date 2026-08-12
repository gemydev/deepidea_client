import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/snakbar_manager.dart';
import '../../../../core/utils/assets_manager/assets_manager.dart';
import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../core/utils/routes_manager/routes_manager.dart';
import '../../../../core/utils/style_manager/style_manager.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_image.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../../shared_widgets/circle_icon_button.dart';
import '../../../../shared_widgets/labeled_form_field.dart';
import '../../../../shared_widgets/otp_digit_field.dart';
import '../../data/models/requests/reset_client_password_with_otp_request.dart';
import '../../data/models/requests/send_client_forgot_password_otp_request.dart';
import '../cubits/forgot_password/reset_client_password_with_otp_cubit.dart';
import '../cubits/forgot_password/send_client_forgot_password_otp_cubit.dart';

class ResetForgotPasswordScreen extends StatefulWidget {
  const ResetForgotPasswordScreen({super.key});

  @override
  State<ResetForgotPasswordScreen> createState() => _ResetForgotPasswordScreenState();
}

class _ResetForgotPasswordScreenState extends State<ResetForgotPasswordScreen> {
  static const int _otpLength = 6;

  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  late final List<TextEditingController> _otpControllers;
  late final List<FocusNode> _otpFocusNodes;

  final ResetClientPasswordWithOtpCubit _resetCubit = sl<ResetClientPasswordWithOtpCubit>();
  final SendClientForgotPasswordOtpCubit _resendCubit = sl<SendClientForgotPasswordOtpCubit>();

  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  late final String _email;

  String get _otp => _otpControllers.map((c) => c.text).join();

  @override
  void initState() {
    super.initState();
    _email = (Get.arguments as String?)?.trim() ?? '';
    _otpControllers = List.generate(_otpLength, (_) => TextEditingController());
    _otpFocusNodes = List.generate(_otpLength, (_) => FocusNode());
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    for (final c in _otpControllers) {
      c.dispose();
    }
    for (final f in _otpFocusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String? _passwordValidator(String? value) {
    final password = value ?? '';
    if (password.isEmpty) return 'مطلوب';
    if (password.length < 8) return 'يجب ألا تقل كلمة المرور عن 8 أحرف';
    if (password.length > 14) return 'كلمة المرور طويلة جدًا';
    return null;
  }

  String? _confirmPasswordValidator(String? value) {
    if (value != _newPasswordController.text) return 'كلمة المرور غير متطابقة';
    return _passwordValidator(value);
  }

  void _submit() {
    if (_otp.length != _otpLength) {
      AppSnackBar.error('أدخل رمز التحقق كاملًا');
      return;
    }
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    _resetCubit.resetPassword(
      ResetClientPasswordWithOtpRequest(
        email: _email,
        otpCode: _otp,
        newPassword: _newPasswordController.text,
        confirmPassword: _confirmPasswordController.text,
      ),
    );
  }

  void _resendOtp() {
    if (_email.isEmpty) return;
    _resendCubit.sendOtp(SendClientForgotPasswordOtpRequest(email: _email));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _resetCubit),
        BlocProvider(create: (_) => _resendCubit),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<ResetClientPasswordWithOtpCubit, ResetClientPasswordWithOtpState>(
            listener: (context, state) {
              if (state is ResetClientPasswordWithOtpLoaded) {
                AppSnackBar.success(
                  state.response.message.isNotEmpty
                      ? state.response.message
                      : 'تم تغيير كلمة المرور بنجاح',
                );
                Get.offAllNamed(Routes.login);
              }
              if (state is ResetClientPasswordWithOtpError) {
                AppSnackBar.error(state.message);
              }
            },
          ),
          BlocListener<SendClientForgotPasswordOtpCubit, SendClientForgotPasswordOtpState>(
            listener: (context, state) {
              if (state is SendClientForgotPasswordOtpLoaded) {
                AppSnackBar.success(
                  state.response.message.isNotEmpty
                      ? state.response.message
                      : 'تم إرسال رمز التحقق',
                );
              }
              if (state is SendClientForgotPasswordOtpError) {
                AppSnackBar.error(state.message);
              }
            },
          ),
        ],
        child: BlocBuilder<ResetClientPasswordWithOtpCubit, ResetClientPasswordWithOtpState>(
          builder: (context, resetState) {
            final isLoading = resetState is ResetClientPasswordWithOtpLoading;

            return Scaffold(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleIconButton(
                                icon: Icons.arrow_back,
                                filled: false,
                                onTap: () => Navigator.pop(context),
                              ),
                              CustomImage(
                                imagePath: CustomAssetsManager.logoPNG,
                                width: 60,
                                height: 60,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          CustomText(
                            'إعادة تعيين كلمة المرور',
                            style: CustomStyleManger.heading1.copyWith(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: CustomColorsManager.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          CustomText(
                            'أدخل رمز التحقق المرسل إلى $_email وكلمة المرور الجديدة.',
                            maxLines: 3,
                            style: CustomStyleManger.normalText.copyWith(
                              color: CustomColorsManager.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 28),
                          CustomText(
                            'رمز التحقق',
                            style: CustomStyleManger.normalText.copyWith(
                              fontWeight: FontWeight.w600,
                              color: CustomColorsManager.mainTextColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (int index = 0; index < _otpLength; index++) ...[
                                  if (index > 0) const SizedBox(width: 8),
                                  OtpDigitField(
                                    controller: _otpControllers[index],
                                    focusNode: _otpFocusNodes[index],
                                    width: 40,
                                    onChanged: (value) {
                                      if (value.isNotEmpty && index < _otpLength - 1) {
                                        _otpFocusNodes[index + 1].requestFocus();
                                      }
                                      if (value.isEmpty && index > 0) {
                                        _otpFocusNodes[index - 1].requestFocus();
                                      }
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          GestureDetector(
                            onTap: _resendOtp,
                            child: Center(
                              child: CustomText(
                                'لم يصلك الرمز؟ إعادة إرسال',
                                style: CustomStyleManger.normalText.copyWith(
                                  fontSize: 15,
                                  color: CustomColorsManager.blueColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 28),
                          LabeledFormField(
                            label: 'كلمة المرور الجديدة',
                            child: CustomTextFormField(
                              hintText: '8 - 14 حرف',
                              controller: _newPasswordController,
                              obscureText: !_isNewPasswordVisible,
                              validator: _passwordValidator,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isNewPasswordVisible ? Icons.visibility_off : Icons.visibility,
                                  color: CustomColorsManager.lightTextColor,
                                ),
                                onPressed: () {
                                  setState(() => _isNewPasswordVisible = !_isNewPasswordVisible);
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          LabeledFormField(
                            label: 'تأكيد كلمة المرور',
                            child: CustomTextFormField(
                              hintText: 'أعد إدخال كلمة المرور',
                              controller: _confirmPasswordController,
                              obscureText: !_isConfirmPasswordVisible,
                              validator: _confirmPasswordValidator,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isConfirmPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: CustomColorsManager.lightTextColor,
                                ),
                                onPressed: () {
                                  setState(
                                    () => _isConfirmPasswordVisible = !_isConfirmPasswordVisible,
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 28),
                          CustomButton(
                            text: isLoading ? 'جاري الحفظ...' : 'حفظ كلمة المرور',
                            onPressed: isLoading ? null : _submit,
                            backGroundColor: CustomColorsManager.primaryColor,
                            child: isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
