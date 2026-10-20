import 'package:remotely/core/helpers/subscription_guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/navigation/route_resume_refresh_mixin.dart';
import '../../../../core/helpers/preferences_manager.dart';
import '../../../../core/utils/assets_manager/assets_manager.dart';
import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../core/utils/routes_manager/routes_manager.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../../shared_widgets/app_header_with_avatar.dart';
import '../../../../shared_widgets/primary_cta_card.dart';

import '../../../support/presentation/cubits/get_all_tickets/get_all_tickets_cubit.dart';
import '../../../support/presentation/widgets/contact_us/contact_us.dart';

import '../widgets/legal_info_part.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.complete = false});

  final bool complete;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteResumeRefreshMixin {
  String clientName = "";
  final GetAllTicketsCubit _ticketsCubit = sl<GetAllTicketsCubit>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadClientName());
    _ticketsCubit.getAllTickets();
  }

  @override
  void refreshWhenRouteResumed() {
    _loadClientName();
    _ticketsCubit.getAllTickets();
  }

  void _loadClientName() {
    final cName = TpPreferencesManager.retrieveString(TpPreferencesManager.clientName) ?? "";
    if (mounted) setState(() => clientName = cName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColorsManager.scaffoldBGColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppHeaderWithAvatar(),
              const SizedBox(height: 15),
              BlocProvider.value(value: _ticketsCubit, child: const LegalInfoScreen()),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: PrimaryCtaCard(
                  iconPath: CustomAssetsManager.ticket2,
                  title: 'رفع تذكرة جديدة',
                  subtitle: 'اخبرنا كيف يمكننا مساعدتك اليوم',
                  onTap: () async {
                    if (!await ensureActiveSubscription()) return;
                    Get.toNamed(Routes.createTicketOrder)?.then((_) {
                      if (!mounted) return;
                      refreshWhenRouteResumed();
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              ContactUsColumn(),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
