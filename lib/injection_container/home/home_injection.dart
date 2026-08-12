import 'package:remotely/features/home/domain/repository/home_repository.dart';
import 'package:remotely/features/home/domain/use_cases/get_packages.dart';
import 'package:remotely/features/home/domain/use_cases/get_service_details_use_case.dart';
import 'package:remotely/features/home/domain/use_cases/submit_sales_delivery.dart';
import 'package:remotely/features/home/domain/use_cases/upload_file_use_case.dart';
import 'package:remotely/features/home/presentation/cubits/get_packages/get_packages_cubit.dart';
import 'package:remotely/features/home/presentation/cubits/get_service_from_service_id/get_service_from_service_id_cubit.dart';
import 'package:remotely/features/home/presentation/cubits/submit_sales_delivery/submit_sales_delivery_cubit.dart';
import 'package:remotely/features/home/presentation/cubits/upload_files/upload_files_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/data/network/dio_client.dart';
import '../../features/home/data/data_source/home_data_source.dart';
import '../../features/home/data/repository/home_repository.dart';
import '../../features/home/domain/use_cases/get_all_services_by_web_id.dart';
import '../../features/home/domain/use_cases/get_list_of_activity_use_case.dart';
import '../../features/home/domain/use_cases/get_list_of_packages_with_fav_use_case.dart';
import '../../features/home/domain/use_cases/get_packages_from_package_bundle.dart';
import '../../features/home/domain/use_cases/get_registered_services_and_packages_use_case.dart';
import '../../features/home/domain/use_cases/get_service_details_web_id_use_case.dart';
import '../../features/home/domain/use_cases/get_service_from_service_id.dart';
import '../../features/home/presentation/cubits/get_all_services_by_web_id/get_all_services_by_web_id_cubit.dart';
import '../../features/home/presentation/cubits/get_list_of_activity/get_list_of_activity_cubit.dart';
import '../../features/home/presentation/cubits/get_list_of_packages_with_fav/get_list_of_packages_with_fav_cubit.dart';
import '../../features/home/presentation/cubits/get_packages_from_package_bundle/get_packages_from_package_bundle_cubit.dart';
import '../../features/home/presentation/cubits/get_registered_services_and_packages/get_registered_services_and_packages_cubit.dart';
import '../../features/home/presentation/cubits/get_service_details/get_service_details_cubit.dart';

Future<void> homeInit(GetIt sl) async {
  // Cubit
  sl.registerFactory(
    () => GetServicesListOfPackagesWithFavCubit(
      getServicesListOfPackagesWithFavUseCase: sl<GetServicesListOfPackagesWithFavUseCase>(),
    ),
  );
  sl.registerFactory(
    () => GetPackagesFromPackageBundleCubit(
      getPackagesFromPackageBundleUseCase: sl<GetPackagesFromPackageBundleUseCase>(),
    ),
  );
  sl.registerFactory(
    () => GetServiceFromServiceIdCubit(
      getServiceFromServiceIdUseCase: sl<GetServiceFromServiceIdUseCase>(),
    ),
  );
  sl.registerFactory(
    () => GetServiceDetailsCubit(
      getServiceDetailsByWebIdUseCase: sl<GetServiceDetailsByWebIdUseCase>(),
      getServiceDetailsUseCase: sl<GetServiceDetailsUseCase>(),
    ),
  );
  sl.registerFactory(
    () => GetListOfActivityCubit(getListOfActivityUseCase: sl<GetListOfActivityUseCase>()),
  );
  sl.registerFactory(
    () => SubmitSalesDeliveryCubit(submitSalesDeliveryUseCase: sl<SubmitSalesDeliveryUseCase>()),
  );
  sl.registerLazySingleton(
    () => GetAllServicesByWebIdCubit(
      getAllServicesByWebIdUseCase: sl<GetAllServicesByWebIdUseCase>(),
    ),
  );
  sl.registerLazySingleton(() => GetPackagesCubit(getPackagesUseCase: sl<GetPackagesUseCase>()));
  sl.registerFactory(
    () => GetRegisteredServicesAndPackagesCubit(
      getRegisteredServicesAndPackagesUseCase: sl<GetRegisteredServicesAndPackagesUseCase>(),
    ),
  );
  sl.registerLazySingleton(() => UploadFilesCubit(uploadFilesUseCase: sl<UploadFilesUseCase>()));

  // UseCase
  sl.registerFactory(
    () => GetServicesListOfPackagesWithFavUseCase(homeRepository: sl<HomeRepository>()),
  );
  sl.registerFactory(
    () => GetPackagesFromPackageBundleUseCase(homeRepository: sl<HomeRepository>()),
  );
  sl.registerFactory(() => GetServiceFromServiceIdUseCase(homeRepository: sl<HomeRepository>()));
  sl.registerFactory(() => GetServiceDetailsUseCase(homeRepository: sl<HomeRepository>()));
  sl.registerFactory(() => GetServiceDetailsByWebIdUseCase(homeRepository: sl<HomeRepository>()));
  sl.registerFactory(() => GetListOfActivityUseCase(homeRepository: sl<HomeRepository>()));
  sl.registerFactory(() => SubmitSalesDeliveryUseCase(homeRepository: sl<HomeRepository>()));
  sl.registerFactory(() => GetAllServicesByWebIdUseCase(homeRepository: sl<HomeRepository>()));
  sl.registerFactory(() => GetPackagesUseCase(homeRepository: sl<HomeRepository>()));
  sl.registerFactory(
    () => GetRegisteredServicesAndPackagesUseCase(homeRepository: sl<HomeRepository>()),
  );
  sl.registerFactory(() => UploadFilesUseCase(homeRepository: sl<HomeRepository>()));

  // Repository
  sl.registerFactory<HomeRepository>(() => HomeRepositoryImp(homeDataSource: sl<HomeDataSource>()));

  // Data sources
  sl.registerFactory<HomeDataSource>(
    () => HomeDataSourceImp(networkClient: sl<NetworkClient>(), prefs: sl<SharedPreferences>()),
  );
}
