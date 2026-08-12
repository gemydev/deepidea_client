import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkHelper {
  static Future<bool> isInternetAvailable() async {
    final connectivityResults = await Connectivity().checkConnectivity();
    if (connectivityResults.contains(ConnectivityResult.none)) {
      return false;
    } else if (connectivityResults.contains(ConnectivityResult.mobile) ||
        connectivityResults.contains(ConnectivityResult.wifi)) {
      try {
        final response = await InternetAddress.lookup('google.com');
        if (response.isNotEmpty && response.first.rawAddress.isNotEmpty) {
          return true;
        }
      } catch (e) {
        return false;
      }
    }

    return false;
  }
}
