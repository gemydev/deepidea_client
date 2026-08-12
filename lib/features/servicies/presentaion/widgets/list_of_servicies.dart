import 'package:flutter/material.dart';

import '../../../home/data/models/responses/get_package_response.dart';
import '../../../home/presentation/widgets/aap_service.dart';

class ListOfServices extends StatelessWidget {
  const ListOfServices({
    super.key,
    this.withPrice = false,
    this.fromAddition = false,
    this.withDetailsAndOrderService = false,
    required this.services,
  });

  final bool withPrice;
  final bool fromAddition;
  final bool withDetailsAndOrderService;
  final List<ServicePackage>? services;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AAPService(
            withAddCart: false,
            withPrice: withPrice,
            fromAddition: fromAddition,
            withDetailsAndOrderService: withDetailsAndOrderService,
            service: services![0],
          ),
        ],
      ),
    );
  }
}
