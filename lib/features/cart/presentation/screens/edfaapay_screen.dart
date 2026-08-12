// // ignore_for_file: avoid_print
// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_edfapay_softpos_sdk/edfapay_softpos_sdk.dart';
// import 'package:hexcolor/hexcolor.dart';
//
// /* add the plugin for below: https://pub.dev/packages/hexcolor */
//
// const authCode = "a2FzaGlmLXNka3VzZXJAZWRmYXBheS5jb206d0lWS2dZTnFAeDUySjQ1";
// const logoPath = "assets/images/edfa_logo.png";
// const amountToPay = "01.010";
//
// class EdfaaPayScreen extends StatefulWidget {
//   const EdfaaPayScreen({super.key});
//
//   @override
//   State<EdfaaPayScreen> createState() => _EdfaaPayScreenState();
// }
//
// class _EdfaaPayScreenState extends State<EdfaaPayScreen> {
//   var _edfaPluginInitiated = false;
//
//   @override
//   void initState() {
//     super.initState();
//     initiate();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.all(15),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const SizedBox(height: 20),
//               Expanded(
//                 flex: 2,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     FractionallySizedBox(
//                         widthFactor: 0.3, child: Image.asset(logoPath)),
//                     const SizedBox(height: 30),
//                     const Text("SDK",
//                         style: TextStyle(
//                             fontSize: 65, fontWeight: FontWeight.w700),
//                         textAlign: TextAlign.center),
//                     const SizedBox(height: 10),
//                     const Text("v0.0.1",
//                         style: TextStyle(
//                             fontSize: 30, fontWeight: FontWeight.bold),
//                         textAlign: TextAlign.center),
//                   ],
//                 ),
//               ),
//               const Expanded(
//                 flex: 1,
//                 child: Padding(
//                   padding: EdgeInsets.all(10),
//                   child: Text(
//                       "You're on your way to enabling your Android App to allow your customers to pay in a very easy and simple way just click the payment button and tap your payment card on NFC enabled Android phone.",
//                       style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.black45),
//                       textAlign: TextAlign.center),
//                 ),
//               ),
//               ElevatedButton(
//                   onPressed: pay,
//                   style: ButtonStyle(
//                       backgroundColor:
//                           MaterialStatePropertyAll(HexColor("06E59F"))),
//                   child: const Text("Pay $amountToPay",
//                       style: TextStyle(color: Colors.black))),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10),
//                 child: Text(
//                     "Click on button above to test the card processing with 10.00 SAR",
//                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
//                     textAlign: TextAlign.center),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   initiate() async {
//     EdfaPayPlugin.initiate(authCode: authCode, environment: Env.STAGING)
//         .then((value) {
//       if (value) {
//         setTheme();
//       }
//
//       setState(() {
//         _edfaPluginInitiated = value;
//       });
//     }).catchError((e) {
//       if (e is PlatformException) {
//         log(e.message ?? e.code);
//       } else {
//         log("Error Initializing SDK");
//       }
//     });
//   }
//
//   setTheme() async {
//     final logo = await assetsBase64(logoPath);
//
//     EdfaPayPlugin.theme
//         .setButtonBackgroundColor("#06E59F")
//         .setButtonTextColor("#000000")
//         .setPoweredByImage(logo)
//         .setHeaderImage(logo);
//   }
//
//   pay() async {
//     if (!_edfaPluginInitiated) {
//       log("Edfapay plugin not initialized.");
//       return;
//     }
//
//     final params = TxnParams(
//       amount: amountToPay,
//       transactionType: TransactionType.purchase,
//     );
//
//     EdfaPayPlugin.enableLogs(true);
//     EdfaPayPlugin.pay(params,
//         onPaymentProcessComplete: (status, code, result, isProcessComplete) {
//       log("Card Payment Process Completed");
//       print('>>> Payment Process Complete');
//     }, onServerTimeOut: () {
//       log("Server Request Timeout");
//       print('>>> Server Timeout');
//       print(' >>> The request timeout while performing transaction at backend');
//     }, onScanCardTimeOut: () {
//       print('>>> Scan Card Timeout');
//       print(' >>> The scan card timeout, no any card tap on device');
//     }, onCancelByUser: () {
//       log("Cancel By User");
//       print('>>> Canceled By User');
//       print(
//           ' >>> User have cancel the scanning/payment process on its own choice');
//     }, onError: (Exception error) {
//       log(error.toString());
//       print('>>> Exception');
//       print(
//           ' >>> "Scanning/Payment process through an exception, Check the logs');
//       print('  >>> ${error.toString()}');
//     });
//   }
// }
