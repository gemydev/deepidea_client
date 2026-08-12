// import 'dart:async';
//
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_edfapay_softpos_sdk/enums/env.dart';
// import 'package:flutter_edfapay_softpos_sdk/enums/transaction_type.dart';
// import 'package:flutter_edfapay_softpos_sdk/flutter_edfapay_softpos_sdk.dart';
// import 'package:flutter_edfapay_softpos_sdk/models/txn_params.dart';
// import 'package:get/get.dart';
//
// import '../../../../../core/helpers/preferences_manager.dart';
//
// part 'soft_pos_state.dart';
//
// class PaymentCubit extends Cubit<PaymentState> {
//   PaymentCubit() : super(PaymentInitial()) {
//     _loadPluginState();
//   }
//
//   bool _edfaPluginInitiated = false;
//
//   bool get isEdfaPluginInitiated => _edfaPluginInitiated;
//
//   Future<bool> initiate() async {
//     final authCode = TpPreferencesManager.retrieveString(
//         TpPreferencesManager.tpSoftPosAuthCode);
//     if (authCode != null && authCode.isNotEmpty) {
//       try {
//         emit(PaymentProcessing());
//         final result = await EdfaPayPlugin.initiate(
//             authCode: authCode, environment: Env.DEVELOPMENT);
//         _edfaPluginInitiated = result;
//
//         if (_edfaPluginInitiated) {
//           _savePluginState(true);
//           emit(PaymentInitialized());
//           return true; // Success
//         } else {
//           emit(PaymentError("failedToInitializeEdfaPayPlugin".tr));
//           return false; // Failure
//         }
//       } catch (e) {
//         emit(PaymentError("${"initializationError".tr}: $e"));
//         return false; // Failure
//       }
//     } else {
//       emit(PaymentError("authCodeNotAvailable".tr));
//       return false; // Failure
//     }
//   }
//
//   // Function to process payment
//   Future<bool> pay(double amount) async {
//     if (!_edfaPluginInitiated) {
//       emit(PaymentError("edfaPayPluginNotInitialized".tr));
//       return false; // Initialization failure
//     }
//
//     emit(PaymentProcessing());
//
//     String formattedAmount = amount.toStringAsFixed(2);
//
//     final params = TxnParams(
//       amount: formattedAmount,
//       transactionType: TransactionType.purchase,
//     );
//
//     try {
//       final completer = Completer<bool>();
//
//       EdfaPayPlugin.pay(
//         params,
//         onPaymentProcessComplete: (status, code, result, isProcessComplete) {
//           emit(PaymentSuccess());
//           completer.complete(true);
//         },
//         onServerTimeOut: () {
//           emit(PaymentError("serverRequestTimeout".tr));
//           completer.complete(false); // Server timeout
//         },
//         onScanCardTimeOut: () {
//           emit(PaymentError("cardScanTimeout".tr));
//           completer.complete(false); // Card scan timeout
//         },
//         onCancelByUser: () {
//           emit(PaymentError("paymentCanceledByUser".tr));
//           completer.complete(false); // User cancellation
//         },
//         onError: (Exception error) {
//           emit(PaymentError("${"paymentError".tr}: ${error.toString()}"));
//           completer.complete(false); // Payment error
//         },
//       );
//
//       return await completer
//           .future; // Wait for the completion and return result
//     } catch (e) {
//       emit(PaymentError("${"paymentException".tr}: $e"));
//       return false; // Exception occurred
//     }
//   }
//
//   // Load the plugin initialization state from shared preferences
//   Future<void> _loadPluginState() async {
//     _edfaPluginInitiated = TpPreferencesManager.retrieveBool(
//             TpPreferencesManager.edfaPluginInitiated) ??
//         false;
//     if (_edfaPluginInitiated) {
//       emit(
//           PaymentInitialized()); // Emit the correct state if previously initialized
//     }
//   }
//
//   // Save the plugin initialization state to shared preferences
//   Future<void> _savePluginState(bool value) async {
//     await TpPreferencesManager.saveBool(
//         TpPreferencesManager.edfaPluginInitiated, value);
//   }
// }
