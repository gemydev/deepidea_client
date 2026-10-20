import 'dart:io';

import 'package:remotely/injection_container/support/support.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/data/network/api.dart';
import '../core/data/network/api_log_interceptor.dart';
import '../core/data/network/dio_client.dart';
import 'auth_injection/auth_injection.dart';
import 'account/account_injection.dart';
import 'cart/cart.dart';
import 'home/home_injection.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //features
  authInit(sl);
  homeInit(sl);
  cartInit(sl);
  supportInit(sl);

  //! External
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  sl.registerFactory<NetworkClient>(() => NetworkClient(sl<Dio>()));
  Dio dio = Dio();
  dio.options = BaseOptions(
    headers: {HttpHeaders.contentTypeHeader: "application/json"},
    validateStatus: (statusCode) {
      if (statusCode == null) {
        return false;
      }
      if (statusCode == 422) {
        // your http status code
        return true;
      } else {
        return statusCode >= 200 && statusCode < 600;
      }
    },
    baseUrl: Api.baseUrlPortal,
  );
  dio.interceptors.add(ApiLogInterceptor());
  sl.registerLazySingleton(() => dio);

  accountInit(sl);
}
