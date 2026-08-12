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
import '../../data/models/requests/send_client_forgot_password_otp_request.dart';
import '../cubits/forgot_password/send_client_forgot_password_otp_cubit.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final SendClientForgotPasswordOtpCubit _cubit = sl<SendClientForgotPasswordOtpCubit>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _emailValidator(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'مطلوب';
    if (!GetUtils.isEmail(email)) return 'البريد الإلكتروني غير صالح';
    return null;
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    _cubit.sendOtp(
      SendClientForgotPasswordOtpRequest(email: _emailController.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _cubit,
      child: BlocConsumer<SendClientForgotPasswordOtpCubit, SendClientForgotPasswordOtpState>(
        listener: (context, state) {
          if (state is SendClientForgotPasswordOtpLoaded) {
            AppSnackBar.success(
              state.response.message.isNotEmpty
                  ? state.response.message
                  : 'تم إرسال رمز التحقق',
            );
            Get.toNamed(
              Routes.resetForgotPassword,
              arguments: _emailController.text.trim(),
            );
          }
          if (state is SendClientForgotPasswordOtpError) {
            AppSnackBar.error(state.message);
          }
        },
        builder: (context, state) {
          final isLoading = state is SendClientForgotPasswordOtpLoading;

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
                          'نسيت كلمة المرور',
                          style: CustomStyleManger.heading1.copyWith(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: CustomColorsManager.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        CustomText(
                          'أدخل البريد الإلكتروني المسجل في حسابك (وليس اسم المستخدم إن كان مختلفاً).',
                          maxLines: 3,
                          style: CustomStyleManger.normalText.copyWith(
                            color: CustomColorsManager.black,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 32),
                        LabeledFormField(
                          label: 'البريد الإلكتروني',
                          child: CustomTextFormField(
                            hintText: 'أدخل البريد الإلكتروني',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: _emailValidator,
                            onFieldSubmitted: (_) => _submit(),
                          ),
                        ),
                        const SizedBox(height: 28),
                        CustomButton(
                          text: isLoading ? 'جاري الإرسال...' : 'إرسال رمز التحقق',
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
    );
  }
}
