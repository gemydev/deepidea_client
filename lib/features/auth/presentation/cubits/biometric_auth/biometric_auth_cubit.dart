import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

part 'biometric_auth_state.dart';

class BiometricAuthCubit extends Cubit<BiometricAuthState> {
  final LocalAuthentication _auth;

  BiometricAuthCubit(this._auth) : super(BiometricInitial());

  /// Check device support and available biometrics
  Future<void> checkAvailability() async {
    try {
      log('[BiometricAuthCubit] Checking device availability...');
      emit(BiometricChecking());

      final isDeviceSupported = await _auth.isDeviceSupported();
      log('[BiometricAuthCubit] Device supported: $isDeviceSupported');

      final canCheckBiometrics = await _auth.canCheckBiometrics;
      log('[BiometricAuthCubit] Can check biometrics: $canCheckBiometrics');

      if (!isDeviceSupported || !canCheckBiometrics) {
        log('[BiometricAuthCubit] Biometric unavailable');
        emit(BiometricUnavailable());
        return;
      }

      final types = await _auth.getAvailableBiometrics();
      log('[BiometricAuthCubit] Available biometrics: $types');

      // Map all types to either face or fingerprint
      if (types.contains(BiometricType.face)) {
        log('[BiometricAuthCubit] Face ID available');
        emit(BiometricAvailable(type: BiometricType.face));
      } else if (types.contains(BiometricType.fingerprint) ||
          types.contains(BiometricType.strong) ||
          types.contains(BiometricType.weak)) {
        log('[BiometricAuthCubit] Fingerprint/Other biometric available');
        emit(BiometricAvailable(type: BiometricType.fingerprint));
      } else {
        log('[BiometricAuthCubit] No recognized biometrics available');
        emit(BiometricUnavailable());
      }
    } catch (e, st) {
      log('[BiometricAuthCubit] Error checking availability: $e\n$st');
      emit(BiometricError(e.toString()));
    }
  }

  /// Perform authentication
  Future<void> authenticate() async {
    try {
      log('[BiometricAuthCubit] Starting authentication...');
      emit(BiometricAuthenticating());

      final success = await _auth.authenticate(
        localizedReason: 'Please authenticate to continue',
        options: const AuthenticationOptions(biometricOnly: true, stickyAuth: true),
      );

      log('[BiometricAuthCubit] Authentication result: $success');

      if (success) {
        emit(BiometricAuthenticated());
      } else {
        emit(BiometricFailed());
      }
    } catch (e, st) {
      log('[BiometricAuthCubit] Authentication error: $e\n$st');
      emit(BiometricError(e.toString()));
    }
  }
}
