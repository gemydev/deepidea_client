import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'call_state.dart';

class CallCubit extends Cubit<CallState> {
  CallCubit() : super(CallIdle());

  void startCall({
    required String calleeID,
    required String calleeName,
    required bool isVideo,
  }) {
    emit(
      CallRinging(calleeID: calleeID, calleeName: calleeName, isVideo: isVideo),
    );
  }

  void onCallAccepted() {
    emit(CallOnGoing());
  }

  void endCall() {
    emit(CallEnded());
  }
}
