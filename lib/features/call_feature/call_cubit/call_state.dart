part of 'call_cubit.dart';

abstract class CallState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CallIdle extends CallState {}

class CallRinging extends CallState {
  final String calleeID;
  final String calleeName;
  final bool isVideo;

  CallRinging({
    required this.calleeID,
    required this.calleeName,
    required this.isVideo,
  });

  @override
  List<Object?> get props => [calleeID, calleeName, isVideo];
}

class CallOnGoing extends CallState {}

class CallEnded extends CallState {}
