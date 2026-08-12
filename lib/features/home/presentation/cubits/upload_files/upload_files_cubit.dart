import 'dart:io';

import 'package:remotely/core/error/failure.dart';
import 'package:remotely/core/helpers/snakbar_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/responses/upload_files_response.dart';
import '../../../domain/use_cases/upload_file_use_case.dart';

part 'upload_files_state.dart';

class UploadFilesCubit extends Cubit<UploadFilesState> {
  UploadFilesCubit({required this.uploadFilesUseCase}) : super(UploadFilesInitial());

  final UploadFilesUseCase uploadFilesUseCase;

  final List<String> _uploadedFileNames = [];
  final List<List<int>> _uploadedFileIdsPerFile = [];

  List<String> get uploadedFileNames => List.unmodifiable(_uploadedFileNames);

  List<int> get uploadedFileIds =>
      _uploadedFileIdsPerFile.expand((ids) => ids).toList();

  Future<void> uploadFiles(File file) async {
    emit(UploadFilesLoading());

    final fileName = file.path.split(RegExp(r'[/\\]')).last;

    final eitherResult = await uploadFilesUseCase(file);

    eitherResult.fold(
      (failure) {
        if (failure is ServerFailure) {
          AppSnackBar.error(failure.message.toString());
        }
        emit(const UploadFilesError(message: 'فشل رفع الملف'));
      },
      (response) async {
        if (response.statusCode != 200) {
          AppSnackBar.error(response.message ?? 'حدث خطأ ما أثناء الرفع');
          emit(const UploadFilesError(message: 'UploadFilesError'));
          emit(UploadFilesInitial());
          return;
        }

        final uploadFilesResponse = UploadFilesResponse.fromJson(response.toJson());

        if (uploadFilesResponse.result != null && uploadFilesResponse.result!.isNotEmpty) {
          _uploadedFileNames.add(fileName);
          _uploadedFileIdsPerFile.add(List<int>.from(uploadFilesResponse.result!));
        }
        debugPrint(uploadedFileIds.toString());

        emit(UploadFilesLoaded(response: uploadFilesResponse));
      },
    );
  }

  void removeUploadedFileAt(int index) {
    if (index < 0 || index >= _uploadedFileNames.length) {
      return;
    }
    _uploadedFileNames.removeAt(index);
    _uploadedFileIdsPerFile.removeAt(index);
    emit(UploadFilesInitial());
  }

  void clearUploadedFiles() {
    _uploadedFileNames.clear();
    _uploadedFileIdsPerFile.clear();
    emit(UploadFilesInitial());
  }
}
