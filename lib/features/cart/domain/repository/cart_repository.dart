import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/requests/post_invoices_with_confirm_request.dart';
import '../../data/models/responses/get_invoices_and_packages_response.dart';
import '../../data/models/responses/post_invoices_with_confirm_response.dart';

abstract class CartRepository {
  Future<Either<Failure, PostInvoicesWithConfirmResponse>>
      postInvoicesWithConfirm(
          PostInvoicesWithConfirmRequest postInvoicesWithConfirmRequest);

  Future<Either<Failure, GetInvoicesAndPackagesResponse>>
      getInvoicesAndPackages();
}
