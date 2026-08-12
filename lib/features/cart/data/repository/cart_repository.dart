import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repository/cart_repository.dart';
import '../data_source/cart_data_source.dart';
import '../models/requests/post_invoices_with_confirm_request.dart';
import '../models/responses/get_invoices_and_packages_response.dart';
import '../models/responses/post_invoices_with_confirm_response.dart';

class CartRepositoryImp extends CartRepository {
  late CartDataSource cartDataSource;

  CartRepositoryImp({required this.cartDataSource});

  @override
  Future<Either<Failure, PostInvoicesWithConfirmResponse>>
      postInvoicesWithConfirm(
          PostInvoicesWithConfirmRequest postInvoicesWithConfirmRequest) async {
    try {
      final data = await cartDataSource
          .postInvoicesWithConfirm(postInvoicesWithConfirmRequest);

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, GetInvoicesAndPackagesResponse>>
      getInvoicesAndPackages() async {
    try {
      final data = await cartDataSource.getInvoicesAndPackages();

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
