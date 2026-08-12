import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'call_cubit/call_cubit.dart';
import 'call_manager.dart';

class CallButton extends StatelessWidget {
  final String calleeID;
  final String calleeName;

  const CallButton({
    required this.calleeID,
    required this.calleeName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallCubit, CallState>(
      builder: (context, state) {
        if (state is CallIdle || state is CallEnded) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.call, color: Colors.green),
                onPressed: () {
                  context.read<CallCubit>().startCall(
                    calleeID: calleeID,
                    calleeName: calleeName,
                    isVideo: false,
                  );
                  CallManager.sendCallInvitation(
                    calleeID: calleeID,
                    calleeName: calleeName,
                    isVideo: false,
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.videocam, color: Colors.blue),
                onPressed: () {
                  context.read<CallCubit>().startCall(
                    calleeID: calleeID,
                    calleeName: calleeName,
                    isVideo: true,
                  );
                  CallManager.sendCallInvitation(
                    calleeID: calleeID,
                    calleeName: calleeName,
                    isVideo: true,
                  );
                },
              ),
            ],
          );
        } else if (state is CallRinging) {
          return const Text(
            "Ringing...",
            style: TextStyle(color: Colors.orange),
          );
        } else if (state is CallOnGoing) {
          return const Text("On Call", style: TextStyle(color: Colors.green));
        }
        return const SizedBox();
      },
    );
  }
}
