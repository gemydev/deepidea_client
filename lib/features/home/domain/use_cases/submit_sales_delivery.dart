import 'package:remotely/features/home/data/models/requests/submit_sales_delivery_request.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/usecase.dart';
import '../../data/models/responses/submit_sales_delivery_response.dart';
import '../repository/home_repository.dart';

class SubmitSalesDeliveryUseCase
    implements UseCase<SubmitSalesDeliveryResponse, SubmitSalesDeliveryRequest> {
  final HomeRepository homeRepository;

  const SubmitSalesDeliveryUseCase({required this.homeRepository});

  @override
  Future<Either<Failure, SubmitSalesDeliveryResponse>> call(
    SubmitSalesDeliveryRequest request,
  ) async {
    return homeRepository.submitSalesDelivery(request);
  }
}
