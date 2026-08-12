import 'package:edfapg_sdk/edfapg_sdk.dart';

// initial class call it from main [EDFA_PAY_INTEGRATION]
//dummy data
//dr Anhar must register in dash board and then get thes real data
class EdfaPaymentService {
  static final EdfaPaymentService instance = EdfaPaymentService._internal();

  EdfaPaymentService._internal();

  void initialize() {
    EdfaPgSdk.instance.config(
      // key: "4ab915af-de8b-4fad-9c4b-7238d3eff192", // real marchent key
      // password: "504fda25-5fa4-43b3-b82e-c0f71b3342b5", // real marchent password

      key: "472de46c-8f4c-4d7d-9152-52352936d0a4", //fake marchent key
      password: "d41242dd29807832f3ba5cc79047dd62", //fake marchent password
      enableDebug: true,
    );
  }
}
