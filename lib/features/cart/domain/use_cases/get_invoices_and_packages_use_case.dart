import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/usecase.dart';
import '../../data/models/responses/get_invoices_and_packages_response.dart';
import '../repository/cart_repository.dart';

class GetInvoicesAndPackagesUseCase
    implements UseCase<GetInvoicesAndPackagesResponse, NoParams> {
  final CartRepository cartRepository;

  const GetInvoicesAndPackagesUseCase({required this.cartRepository});

  @override
  Future<Either<Failure, GetInvoicesAndPackagesResponse>> call(
      NoParams noParams) async {
    return cartRepository.getInvoicesAndPackages();
  }
}
