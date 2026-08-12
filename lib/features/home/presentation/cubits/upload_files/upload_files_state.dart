part of 'upload_files_cubit.dart';

sealed class UploadFilesState extends Equatable {
  const UploadFilesState();
}

final class UploadFilesInitial extends UploadFilesState {
  @override
  List<Object> get props => [];
}

final class UploadFilesLoading extends UploadFilesState {
  @override
  List<Object> get props => [];
}

class UploadFilesLoaded extends UploadFilesState {
  final UploadFilesResponse response;

  const UploadFilesLoaded({required this.response});

  @override
  List<Object> get props => [];
}

class UploadFilesError extends UploadFilesState {
  final String message;

  const UploadFilesError({required this.message});

  @override
  List<Object> get props => [];
}
