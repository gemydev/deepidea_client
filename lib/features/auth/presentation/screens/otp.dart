import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/preferences_manager.dart';
import '../../../../core/helpers/snakbar_manager.dart';
import '../../../../core/utils/assets_manager/assets_manager.dart';
import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../core/utils/routes_manager/routes_manager.dart';
import '../../../../core/utils/style_manager/style_manager.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_image.dart';
import '../../../../shared_widgets/circle_icon_button.dart';
import '../../../../shared_widgets/otp_digit_field.dart';
import '../../../../injection_container/injection_container.dart';
import '../../data/models/requests/send_otp_verification_request.dart';
import '../../data/models/requests/verify_otp.dart';
import '../cubits/SendOtpVerification/send_otp_verification_cubit.dart';
import '../cubits/verifyOtp/verify_otp_cubit.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  static const int otpLength = 4;

  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  final VerifyOtpCubit _verifyOtpCubit = sl<VerifyOtpCubit>();

  String get _otp => _controllers.map((c) => c.text).join();

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(otpLength, (_) => TextEditingController());
    _focusNodes = List.generate(otpLength, (_) => FocusNode());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes.first.requestFocus();
    });
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String email = Get.arguments[0];
    final String password = Get.arguments[1];

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _verifyOtpCubit),
        BlocProvider.value(value: sl<SendOtpVerificationCubit>()),
      ],
      child: BlocListener<SendOtpVerificationCubit, SendOtpVerificationState>(
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
            child: BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
            listener: (context, state) {
              if (state is VerifyOtpLoaded) {
                AppSnackBar.success(state.response.message);
                TpPreferencesManager.saveBool(TpPreferencesManager.isLoggedIn, true);
                Get.offAllNamed(Routes.baseOfApp);
              }

              if (state is VerifyOtpError) {
                AppSnackBar.error(state.message);
              }
            },
            builder: (context, state) {
              final bool isLoading = state is VerifyOtpLoading;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                child: SingleChildScrollView(
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
                        'تأكيد الرمز',
                        style: CustomStyleManger.heading1.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: CustomColorsManager.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      CustomText(
                        'أدخل رمز التحقق اللي انرسل على بريدك الإلكتروني لتأكيد حسابك بالكامل.',
                        maxLines: 2,
                        style: CustomStyleManger.normalText.copyWith(
                          color: CustomColorsManager.black,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int index = 0; index < otpLength; index++) ...[
                              if (index > 0) const SizedBox(width: 12),
                              OtpDigitField(
                                controller: _controllers[index],
                                focusNode: _focusNodes[index],
                                onChanged: (value) {
                                  if (value.isNotEmpty && index < otpLength - 1) {
                                    _focusNodes[index + 1].requestFocus();
                                  }
                                  if (value.isEmpty && index > 0) {
                                    _focusNodes[index - 1].requestFocus();
                                  }
                                  setState(() {});
                                  if (_controllers.map((c) => c.text).join().length == otpLength) {
                                    FocusScope.of(context).unfocus();
                                  }
                                },
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: CustomText(
                          'وصلك رمز على جوالك.',
                          style: CustomStyleManger.normalText.copyWith(
                            fontSize: 16,
                            color: CustomColorsManager.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          sl<SendOtpVerificationCubit>().sendOtpVerification(
                            SendOtpVerificationRequest(
                              email:
                                  TpPreferencesManager.retrieveString(
                                    TpPreferencesManager.clientEmail,
                                  ) ??
                                  "",
                              userId: int.parse(
                                TpPreferencesManager.retrieveString(TpPreferencesManager.userId) ??
                                    "0",
                              ),
                            ),
                          );
                        },
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
                      const SizedBox(height: 32),
                      CustomButton(
                        text: isLoading ? 'جاري التحقق...' : 'التحقق من الرمز',
                        textColor: (_otp.length == otpLength && !isLoading)
                            ? CustomColorsManager.white
                            : CustomColorsManager.black,
                        backGroundColor: _otp.length == otpLength && !isLoading
                            ? CustomColorsManager.primaryColor
                            : CustomColorsManager.unSelectedBorderColor,
                        onPressed: (_otp.length != otpLength || isLoading)
                            ? null
                            : () {
                                _verifyOtpCubit.verifyOtp(
                                  VerifyOtpRequest(
                                    userId: int.parse(
                                      TpPreferencesManager.retrieveString(
                                            TpPreferencesManager.userId,
                                          ) ??
                                          "0",
                                    ),
                                    otp: _otp,
                                    email: email,
                                    password: password,
                                  ),
                                );
                              },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ),
    );
  }
}
