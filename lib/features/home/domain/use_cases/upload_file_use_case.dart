import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/usecase.dart';
import '../../data/models/responses/upload_files_response.dart';
import '../repository/home_repository.dart';

class UploadFilesUseCase implements UseCase<UploadFilesResponse, File> {
  final HomeRepository homeRepository;

  const UploadFilesUseCase({required this.homeRepository});

  @override
  Future<Either<Failure, UploadFilesResponse>> call(File file) async {
    return homeRepository.uploadFiles(file);
  }
}
