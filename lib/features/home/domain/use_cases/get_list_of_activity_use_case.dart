import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/usecase.dart';
import '../../data/models/responses/get_list_of_activity_response.dart';
import '../repository/home_repository.dart';

class GetListOfActivityUseCase
    implements UseCase<GetListOfActivityResponse, Unit> {
  final HomeRepository homeRepository;

  const GetListOfActivityUseCase({required this.homeRepository});

  @override
  Future<Either<Failure, GetListOfActivityResponse>> call(Unit unit) async {
    return homeRepository.getListOfActivity();
  }
}
