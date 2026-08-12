import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/usecase.dart';
import '../../data/models/responses/get_ticket_categories_response.dart';
import '../repository/support_repository.dart';

class GetTicketCategoriesUseCase
    implements UseCase<GetTicketCategoriesResponse, GetTicketCategoriesParams> {
  const GetTicketCategoriesUseCase({required this.supportRepository});

  final SupportRepository supportRepository;

  @override
  Future<Either<Failure, GetTicketCategoriesResponse>> call(
    GetTicketCategoriesParams params,
  ) async {
    return supportRepository.getTicketCategories(parentId: params.parentId);
  }
}

class GetTicketCategoriesParams extends Equatable {
  const GetTicketCategoriesParams({this.parentId});

  final int? parentId;

  @override
  List<Object?> get props => [parentId];
}
