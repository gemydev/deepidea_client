import 'package:remotely/features/cart/domain/repository/cart_repository.dart';
import 'package:remotely/features/cart/domain/use_cases/get_invoices_and_packages_use_case.dart';
import 'package:remotely/features/cart/presentation/cubit/get_invoices_and_packages/get_invoices_and_packages_cubit.dart';
import 'package:remotely/features/cart/presentation/cubit/post_invoices/post_invoices_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/data/network/dio_client.dart';
import '../../features/cart/data/data_source/cart_data_source.dart';
import '../../features/cart/data/repository/cart_repository.dart';
import '../../features/cart/domain/use_cases/post_invoices_with_confirm_use_case.dart';
import '../../features/cart/presentation/cubit/cart/cart_cubit.dart';

Future<void> cartInit(GetIt sl) async {
  // Cubit
  sl.registerLazySingleton(() => CartCubit());
  sl.registerFactory(
    () => PostInvoicesCubit(postInvoicesUseCase: sl<PostInvoicesWithConfirmUseCase>()),
  );
  sl.registerFactory(
    () => GetInvoicesAndPackagesCubit(
      getInvoicesAndPackagesUseCase: sl<GetInvoicesAndPackagesUseCase>(),
    ),
  );

  // UseCase
  sl.registerFactory(() => PostInvoicesWithConfirmUseCase(cartRepository: sl<CartRepository>()));
  sl.registerFactory(() => GetInvoicesAndPackagesUseCase(cartRepository: sl<CartRepository>()));

  // Repository
  sl.registerFactory<CartRepository>(() => CartRepositoryImp(cartDataSource: sl<CartDataSource>()));

  // Data sources
  sl.registerFactory<CartDataSource>(
    () => CartDataSourceImp(networkClient: sl<NetworkClient>(), prefs: sl<SharedPreferences>()),
  );
}
