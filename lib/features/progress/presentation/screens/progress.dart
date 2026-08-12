import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container/injection_container.dart';
import '../../../../shared_widgets/shared_widgets.dart';
import '../../../home/presentation/widgets/legal_info_part.dart';
import '../../../support/domain/use_cases/get_all_tickets_use_case.dart';
import '../../../support/presentation/cubits/get_all_tickets/get_all_tickets_cubit.dart';
import '../widgets/package_details.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHeaderWithAvatar(),
            const SizedBox(height: 15),
            PackageDetails(),
            const SizedBox(height: 15),
            BlocProvider(
              create: (context) =>
                  GetAllTicketsCubit(getAllTicketsUseCase: sl<GetAllTicketsUseCase>())
                    ..getAllTickets(),
              child: const LegalInfoScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
