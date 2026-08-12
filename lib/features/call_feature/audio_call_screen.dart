import 'package:flutter/material.dart';

import 'call_manager.dart';

class AudioCallScreen extends StatelessWidget {
  final String callID;
  final String userID;
  final String userName;

  const AudioCallScreen({
    super.key,
    required this.callID,
    required this.userID,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CallManager.audioCallPage(
        callID: callID,
        userID: userID,
        userName: userName,
      ),
    );
  }
}
