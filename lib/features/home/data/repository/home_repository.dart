import 'dart:io';

import 'package:remotely/features/home/data/models/responses/get_service_details_response.dart';
import 'package:remotely/features/home/data/models/responses/upload_files_response.dart';
import 'package:remotely/features/home/data/models/responses/get_package_response.dart';
import 'package:remotely/features/home/data/models/responses/get_list_of_activity_response.dart';
import 'package:remotely/features/home/data/models/responses/submit_sales_delivery_response.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repository/home_repository.dart';
import '../data_source/home_data_source.dart';
import '../models/requests/get_packages_from_backage_bundel.dart';
import '../models/requests/get_service_from_service_id.dart';
import '../models/requests/submit_sales_delivery_request.dart';
import '../models/responses/get_all_services_by_web_id_response.dart';
import '../models/responses/get_registered_services_and_packages_response.dart';
import '../models/responses/get_packages_from_package_bundle_response.dart';
import '../models/responses/get_services_list_of_packages_with_fav_response.dart';
import '../models/responses/get_service_from_service_id.dart';

class HomeRepositoryImp extends HomeRepository {
  late HomeDataSource homeDataSource;

  HomeRepositoryImp({required this.homeDataSource});

  @override
  Future<Either<Failure, GetListOfActivityResponse>> getListOfActivity() async {
    try {
      final data = await homeDataSource.getListOfActivity();

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, GetPackagesResponse>> getPackages() async {
    try {
      final data = await homeDataSource.getPackages();

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, GetRegisteredServicesAndPackagesResponse>>
  getRegisteredServicesAndPackages() async {
    try {
      final data = await homeDataSource.getRegisteredServicesAndPackages();

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, GetAllServicesByWebIdResponse>> getAllServicesByWebId() async {
    try {
      final data = await homeDataSource.getAllServicesByWebId();

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, GetServicesListOfPackagesWithFavResponse>>
  getServicesListOfPackagesWithFav(String id) async {
    try {
      final data = await homeDataSource.getServicesListOfPackagesWithFav(id);

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, GetPackagesFromPackageBundleResponse>> getPackagesFromPackageBundle(
    GetPackagesFromPackageBundleRequest request,
  ) async {
    try {
      final data = await homeDataSource.getPackagesFromPackageBundle(request);

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, GetServiceFromServiceIdResponse>> getServiceFromServiceId(
    GetServiceFromServiceIdRequest request,
  ) async {
    try {
      final data = await homeDataSource.getServiceFromServiceId(request);

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, GetServiceDetailsResponse>> getServiceDetails(String serviceId) async {
    try {
      final data = await homeDataSource.getServiceDetails(serviceId);

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, SubmitSalesDeliveryResponse>> submitSalesDelivery(
    SubmitSalesDeliveryRequest request,
  ) async {
    try {
      final data = await homeDataSource.submitSalesDelivery(request);

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, GetServiceDetailsResponse>> getServiceDetailsByWebId(String webId) async {
    try {
      final data = await homeDataSource.getServiceDetailsByWebId(webId);

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UploadFilesResponse>> uploadFiles(File file) async {
    try {
      final data = await homeDataSource.uploadFiles(file);

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
