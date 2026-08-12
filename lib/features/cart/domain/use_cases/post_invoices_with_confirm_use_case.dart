import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/usecase.dart';
import '../../data/models/requests/post_invoices_with_confirm_request.dart';
import '../../data/models/responses/post_invoices_with_confirm_response.dart';
import '../repository/cart_repository.dart';

class PostInvoicesWithConfirmUseCase
    implements
        UseCase<
          PostInvoicesWithConfirmResponse,
          PostInvoicesWithConfirmRequest
        > {
  final CartRepository cartRepository;

  const PostInvoicesWithConfirmUseCase({required this.cartRepository});

  @override
  Future<Either<Failure, PostInvoicesWithConfirmResponse>> call(
    PostInvoicesWithConfirmRequest postInvoicesWithConfirmRequest,
  ) async {
    return cartRepository.postInvoicesWithConfirm(
      postInvoicesWithConfirmRequest,
    );
  }
}
