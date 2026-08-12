import 'package:remotely/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:remotely/features/auth/domain/use_cases/send_otp_verification_use_case.dart';
import 'package:remotely/features/auth/domain/use_cases/verify_otp_use_case.dart';
import 'package:remotely/features/auth/domain/use_cases/reset_client_password_with_otp_use_case.dart';
import 'package:remotely/features/auth/domain/use_cases/send_client_forgot_password_otp_use_case.dart';
import 'package:remotely/features/auth/presentation/cubits/forgot_password/reset_client_password_with_otp_cubit.dart';
import 'package:remotely/features/auth/presentation/cubits/forgot_password/send_client_forgot_password_otp_cubit.dart';
import 'package:remotely/features/auth/presentation/cubits/SendOtpVerification/send_otp_verification_cubit.dart';
import 'package:remotely/features/auth/presentation/cubits/logout/logout_cubit.dart';
import 'package:remotely/features/auth/presentation/cubits/verifyOtp/verify_otp_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/data/network/dio_client.dart';
import '../../features/auth/data/data_source/auth_data_source.dart';
import '../../features/auth/data/repository/auth_repository.dart';
import '../../features/auth/domain/repository/auth_repository.dart';
import '../../features/auth/domain/use_cases/login_use_case.dart';
import '../../features/auth/presentation/cubits/login/login_cubit.dart';

Future<void> authInit(GetIt sl) async {
  // Cubit
  sl.registerFactory(() => LoginCubit(loginUseCase: sl<LoginUseCase>()));
  sl.registerFactory(() => LogoutCubit(logoutUseCase: sl<LogoutUseCase>()));
  sl.registerFactory(
    () => SendOtpVerificationCubit(sendOtpVerificationUseCase: sl<SendOtpVerificationUseCase>()),
  );
  sl.registerFactory(() => VerifyOtpCubit(verifyOtpUseCase: sl<VerifyOtpUseCase>()));

  sl.registerFactory(
    () => SendClientForgotPasswordOtpCubit(useCase: sl<SendClientForgotPasswordOtpUseCase>()),
  );
  sl.registerFactory(
    () => ResetClientPasswordWithOtpCubit(useCase: sl<ResetClientPasswordWithOtpUseCase>()),
  );

  // UseCase
  sl.registerFactory(() => LoginUseCase(authRepository: sl<AuthRepository>()));
  sl.registerFactory(() => LogoutUseCase(authRepository: sl<AuthRepository>()));
  sl.registerFactory(() => SendOtpVerificationUseCase(authRepository: sl<AuthRepository>()));
  sl.registerFactory(() => VerifyOtpUseCase(authRepository: sl<AuthRepository>()));
  sl.registerFactory(
    () => SendClientForgotPasswordOtpUseCase(authRepository: sl<AuthRepository>()),
  );
  sl.registerFactory(
    () => ResetClientPasswordWithOtpUseCase(authRepository: sl<AuthRepository>()),
  );

  // Repository
  sl.registerFactory<AuthRepository>(() => AuthRepositoryImp(authDataSource: sl<AuthDataSource>()));

  // Data sources
  sl.registerFactory<AuthDataSource>(
    () => AuthDataSourceImp(networkClient: sl<NetworkClient>(), prefs: sl<SharedPreferences>()),
  );
}
