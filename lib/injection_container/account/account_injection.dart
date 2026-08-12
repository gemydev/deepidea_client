import 'package:get_it/get_it.dart';

import '../../core/data/network/dio_client.dart';
import '../../features/account/data/data_source/account_data_source.dart';
import '../../features/account/data/repository/account_repository_imp.dart';
import '../../features/account/domain/repository/account_repository.dart';
import '../../features/account/domain/use_cases/get_client_subscription_status_use_case.dart';
import '../../features/account/presentation/cubits/client_subscription_status/client_subscription_status_cubit.dart';

/// Registers account feature dependencies. Safe to call more than once (e.g. after hot reload).
void accountInit(GetIt sl) {
  if (sl.isRegistered<ClientSubscriptionStatusCubit>()) {
    return;
  }

  sl.registerFactory<AccountDataSource>(
    () => AccountDataSourceImp(networkClient: sl<NetworkClient>()),
  );

  sl.registerFactory<AccountRepository>(
    () => AccountRepositoryImp(accountDataSource: sl<AccountDataSource>()),
  );

  sl.registerFactory(
    () => GetClientSubscriptionStatusUseCase(accountRepository: sl<AccountRepository>()),
  );

  sl.registerFactory(
    () => ClientSubscriptionStatusCubit(
      getClientSubscriptionStatusUseCase: sl<GetClientSubscriptionStatusUseCase>(),
    ),
  );
}
