import 'package:flutter/material.dart';

import 'call_manager.dart';

class VideoCallScreen extends StatelessWidget {
  final String callID;
  final String userID;
  final String userName;

  const VideoCallScreen({
    super.key,
    required this.callID,
    required this.userID,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CallManager.videoCallPage(
        callID: callID,
        userID: userID,
        userName: userName,
      ),
    );
  }
}
