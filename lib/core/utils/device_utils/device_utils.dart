import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum DeviceKind { tablet, mobile, sunmi }

class TpDeviceUtils {
  static void makeTabletLandscape() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
