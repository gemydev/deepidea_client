import 'dart:io';

import 'package:remotely/features/home/data/models/requests/get_service_from_service_id.dart';
import 'package:remotely/features/home/data/models/responses/get_registered_services_and_packages_response.dart';
import 'package:remotely/features/home/data/models/responses/upload_files_response.dart';
import 'package:remotely/features/home/data/models/responses/get_package_response.dart';
import 'package:remotely/features/home/data/models/responses/get_list_of_activity_response.dart';
import 'package:remotely/features/home/data/models/responses/get_service_from_service_id.dart';
import 'package:remotely/features/home/data/models/responses/submit_sales_delivery_response.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/data/network/api.dart';
import '../../../../core/data/network/dio_client.dart';
import '../../../../core/error/exceptions.dart';
import '../models/requests/get_packages_from_backage_bundel.dart';
import '../models/requests/submit_sales_delivery_request.dart';
import '../models/responses/get_all_services_by_web_id_response.dart';
import '../models/responses/get_packages_from_package_bundle_response.dart';
import '../models/responses/get_services_list_of_packages_with_fav_response.dart';

abstract class HomeDataSource {
  getListOfActivity();

  getServicesListOfPackagesWithFav(String id);

  getPackagesFromPackageBundle(GetPackagesFromPackageBundleRequest request);

  getServiceFromServiceId(GetServiceFromServiceIdRequest request);

  getServiceDetailsByWebId(String webId);

  getServiceDetails(String serviceId);

  submitSalesDelivery(SubmitSalesDeliveryRequest request);

  getPackages();

  getRegisteredServicesAndPackages();

  getAllServicesByWebId();

  uploadFiles(File file);
}

class HomeDataSourceImp implements HomeDataSource {
  final NetworkClient networkClient;
  final SharedPreferences prefs;

  HomeDataSourceImp({required this.networkClient, required this.prefs});

  @override
  getListOfActivity() async {
    try {
      Map<String, dynamic> response = await networkClient.getData(
        endpoint: Api.getListOfActivity(),
      );

      final GetListOfActivityResponse listOfActivityResponse = GetListOfActivityResponse.fromJson(
        response,
      );

      return listOfActivityResponse;
    } on DioException catch (e) {
      throw ServerException(message: "Server Exception: ${e.toString()}");
    }
  }

  @override
  getPackages() async {
    try {
      Map<String, dynamic> response = await networkClient.getData(endpoint: Api.getPackages());

      final GetPackagesResponse packagesResponse = GetPackagesResponse.fromJson(response);

      return packagesResponse;
    } on DioException catch (e) {
      throw ServerException(message: "Server Exception: ${e.toString()}");
    }
  }

  @override
  getRegisteredServicesAndPackages() async {
    try {
      Map<String, dynamic> response = await networkClient.getData(
        endpoint: Api.getRegisteredServicesAndPackages(),
      );

      final GetRegisteredServicesAndPackagesResponse packagesResponse =
          GetRegisteredServicesAndPackagesResponse.fromJson(response);

      return packagesResponse;
    } on DioException catch (e) {
      throw ServerException(message: "Server Exception: ${e.toString()}");
    }
  }

  @override
  getAllServicesByWebId() async {
    try {
      Map<String, dynamic> response = await networkClient.getData(
        endpoint: Api.getAllServicesByWebId(),
      );

      final GetAllServicesByWebIdResponse packagesResponse = GetAllServicesByWebIdResponse.fromJson(
        response,
      );

      return packagesResponse;
    } on DioException catch (e) {
      throw ServerException(message: "Server Exception: ${e.toString()}");
    }
  }

  @override
  getServicesListOfPackagesWithFav(String id) async {
    try {
      Map<String, dynamic> response = await networkClient.getData(
        endpoint: Api.getServicesListOfPackagesWithFav(id),
      );
      final GetServicesListOfPackagesWithFavResponse getServicesListOfPackagesWithFavResponse =
          GetServicesListOfPackagesWithFavResponse.fromJson(response);

      return getServicesListOfPackagesWithFavResponse;
    } on DioException catch (e) {
      throw ServerException(message: "Server Exception: ${e.toString()}");
    }
  }

  @override
  getPackagesFromPackageBundle(GetPackagesFromPackageBundleRequest request) async {
    try {
      Map<String, dynamic> response = await networkClient.getData(
        endpoint: Api.getPackagesFromPackageBundle(request.bundleId, request.invoiceId),
      );
      final GetPackagesFromPackageBundleResponse getPackagesFromPackageBundleResponse =
          GetPackagesFromPackageBundleResponse.fromJson(response);

      return getPackagesFromPackageBundleResponse;
    } on DioException catch (e) {
      throw ServerException(message: "Server Exception: ${e.toString()}");
    }
  }

  @override
  getServiceFromServiceId(GetServiceFromServiceIdRequest request) async {
    try {
      Map<String, dynamic> response = await networkClient.getData(
        endpoint: Api.getServiceFromServiceId(request.serviceId, request.invoiceId),
      );
      final GetServiceFromServiceIdResponse getPackagesFromPackageBundleResponse =
          GetServiceFromServiceIdResponse.fromJson(response);

      return getPackagesFromPackageBundleResponse;
    } on DioException catch (e) {
      throw ServerException(message: "Server Exception: ${e.toString()}");
    }
  }

  @override
  getServiceDetails(String serviceId) {
    throw UnimplementedError('getServiceDetails');
  }

  @override
  getServiceDetailsByWebId(String webId) {
    throw UnimplementedError('getServiceDetailsByWebId');
  }

  @override
  submitSalesDelivery(SubmitSalesDeliveryRequest request) async {
    try {
      Map<String, dynamic> response = await networkClient.postData(
        endpoint: Api.submitSalesDelivery(),
        query: request.toJson(),
      );
      final SubmitSalesDeliveryResponse submitSalesDeliveryResponse =
          SubmitSalesDeliveryResponse.fromJson(response);

      return submitSalesDeliveryResponse;
    } on DioException catch (e) {
      throw ServerException(message: "Server Exception: ${e.toString()}");
    }
  }

  @override
  uploadFiles(File file) async {
    try {
      var data = FormData.fromMap({
        'files': [await MultipartFile.fromFile(file.path, filename: path.basename(file.path))],
      });

      Map<String, dynamic> response = await networkClient.postData(
        endpoint: Api.uploadFiles(),
        query: data,
      );
      final UploadFilesResponse uploadFilesResponse = UploadFilesResponse.fromJson(response);

      return uploadFilesResponse;
    } on DioException catch (e) {
      throw ServerException(message: "Server Exception: ${e.toString()}");
    }
  }
}
