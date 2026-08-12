import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/navigation/route_resume_refresh_mixin.dart';
import '../../../../core/utils/assets_manager/assets_manager.dart';
import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../core/utils/routes_manager/routes_manager.dart';

import '../../../../injection_container/injection_container.dart';
import '../../../../shared_widgets/action_card.dart';
import '../../../../shared_widgets/app_header_with_avatar.dart';
import '../../../../shared_widgets/hero_message.dart';

import '../cubits/get_all_tickets/get_all_tickets_cubit.dart';
import '../cubits/get_ticket_faq/get_ticket_faq_cubit.dart';
import '../widgets/contact_us/contact_us.dart';
import '../widgets/ticket_faq_section.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> with RouteResumeRefreshMixin {
  String clientName = "";
  final GetAllTicketsCubit _getAllTicketsCubit = sl<GetAllTicketsCubit>();
  final GetTicketFaqCubit _getTicketFaqCubit = sl<GetTicketFaqCubit>();

  @override
  void initState() {
    super.initState();

    _getAllTicketsCubit.getAllTickets();
    _getTicketFaqCubit.loadFaqs();
  }

  @override
  void refreshWhenRouteResumed() {
    _getAllTicketsCubit.getAllTickets();
    _getTicketFaqCubit.loadFaqs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColorsManager.scaffoldBGColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppHeaderWithAvatar(),
              const SizedBox(height: 20),
              HeroMessage(
                iconPath: CustomAssetsManager.ebene_1,
                title: 'كيف نقدر نساعدك اليوم؟',
                description:
                    'نحن هنا لدعمك والإجابة عن استفساراتك، لا تتردد في إخبارنا بما تحتاجه وسنكون سعداء بخدمتك.',
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ActionCard(
                  iconPath: CustomAssetsManager.ticket2,
                  iconBgColor: CustomColorsManager.primaryColor,
                  title: 'تقديم تذكرة جديدة',
                  subtitle: 'أرسل طلبك وسنتواصل معك قريبا.',
                  onTap: () {
                    Get.toNamed(Routes.createTicketOrder)?.then((_) {
                      if (!mounted) return;
                      refreshWhenRouteResumed();
                    });
                  },
                ),
              ),
              const SizedBox(height: 24),
              TicketFaqSection(cubit: _getTicketFaqCubit),
              const SizedBox(height: 24),
              ContactUsColumn(),
              const SizedBox(height: 24),
              // SectionTitle('محادثات مفتوحة'),
              // const SizedBox(height: 24),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16),
              //   child: Column(
              //     children: [
              //       ChatCard(
              //         iconPath: CustomAssetsManager.refreshCircle,
              //         iconBgColor: CustomColorsManager.icontBGColor,
              //         title: 'محادثة بدعم العملاء',
              //         subtitle: 'دردشة فورية مع خدمة العملاء',
              //         hintColor: CustomColorsManager.green,
              //         hintText: 'خدمة العملاء في انتظار ردك',
              //         onTap: () => Get.toNamed(Routes.createTicketOrder),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
