import 'dart:io';

import 'package:remotely/features/home/data/models/responses/upload_files_response.dart';
import 'package:remotely/features/home/data/models/responses/get_package_response.dart';
import 'package:remotely/features/home/data/models/responses/get_list_of_activity_response.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/requests/get_packages_from_backage_bundel.dart';
import '../../data/models/requests/get_service_from_service_id.dart';
import '../../data/models/requests/submit_sales_delivery_request.dart';
import '../../data/models/responses/get_all_services_by_web_id_response.dart';
import '../../data/models/responses/get_registered_services_and_packages_response.dart';
import '../../data/models/responses/get_service_details_response.dart';
import '../../data/models/responses/get_packages_from_package_bundle_response.dart';
import '../../data/models/responses/get_services_list_of_packages_with_fav_response.dart';
import '../../data/models/responses/get_service_from_service_id.dart';
import '../../data/models/responses/submit_sales_delivery_response.dart';

abstract class HomeRepository {
  Future<Either<Failure, GetListOfActivityResponse>> getListOfActivity();

  Future<Either<Failure, GetPackagesResponse>> getPackages();

  Future<Either<Failure, GetRegisteredServicesAndPackagesResponse>>
  getRegisteredServicesAndPackages();

  Future<Either<Failure, GetAllServicesByWebIdResponse>> getAllServicesByWebId();

  Future<Either<Failure, GetServicesListOfPackagesWithFavResponse>>
  getServicesListOfPackagesWithFav(String id);

  Future<Either<Failure, GetPackagesFromPackageBundleResponse>> getPackagesFromPackageBundle(
    GetPackagesFromPackageBundleRequest request,
  );

  Future<Either<Failure, GetServiceFromServiceIdResponse>> getServiceFromServiceId(
    GetServiceFromServiceIdRequest request,
  );

  Future<Either<Failure, GetServiceDetailsResponse>> getServiceDetails(String serviceId);

  Future<Either<Failure, SubmitSalesDeliveryResponse>> submitSalesDelivery(
    SubmitSalesDeliveryRequest request,
  );

  Future<Either<Failure, GetServiceDetailsResponse>> getServiceDetailsByWebId(String webId);

  Future<Either<Failure, UploadFilesResponse>> uploadFiles(File file);
}
