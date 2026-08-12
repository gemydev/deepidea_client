import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/usecase.dart';
import '../../data/models/responses/get_faqs_by_category_response.dart';
import '../repository/support_repository.dart';

class GetFaqsByCategoryUseCase
    implements UseCase<GetFaqsByCategoryResponse, GetFaqsByCategoryParams> {
  const GetFaqsByCategoryUseCase({required this.supportRepository});

  final SupportRepository supportRepository;

  @override
  Future<Either<Failure, GetFaqsByCategoryResponse>> call(GetFaqsByCategoryParams params) async {
    return supportRepository.getFAQsByCategory(params.categoryId);
  }
}

class GetFaqsByCategoryParams extends Equatable {
  const GetFaqsByCategoryParams({required this.categoryId});

  final int categoryId;

  @override
  List<Object?> get props => [categoryId];
}
