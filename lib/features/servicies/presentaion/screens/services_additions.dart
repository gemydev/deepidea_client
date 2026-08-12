import 'package:flutter/material.dart';

import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../core/widgets/custom_tap_bar.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../home/presentation/cubits/get_all_services_by_web_id/get_all_services_by_web_id_cubit.dart';
import '../../../home/presentation/cubits/get_packages/get_packages_cubit.dart';
import '../../../home/presentation/widgets/cart_button.dart';
import '../../../support/presentation/widgets/sub_app_bar.dart';
import 'all_services.dart';
import 'services.dart';

class ServicesAndAdditions extends StatefulWidget {
  const ServicesAndAdditions({super.key});

  @override
  State<ServicesAndAdditions> createState() => _ServicesAndAdditionsState();
}

class _ServicesAndAdditionsState extends State<ServicesAndAdditions> {
  late final GetPackagesCubit getPackagesCubit;
  late final GetAllServicesByWebIdCubit getAllServicesByWebIdCubit;

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    // Cubits
    getPackagesCubit = sl<GetPackagesCubit>()..getPackages();
    getAllServicesByWebIdCubit = sl<GetAllServicesByWebIdCubit>()
      ..getAllServicesByWebId();

    // بعد قليل، نتحقق من وجود بيانات
    Future.delayed(Duration.zero, () {
      bool hasPackages = false;
      bool hasServices = false;

      final packagesState = getPackagesCubit.state;
      final servicesState = getAllServicesByWebIdCubit.state;

      // تحقق من Packages
      if (packagesState is GetPackagesLoaded) {
        hasPackages = packagesState.response.info?.isNotEmpty == true;
      }

      // تحقق من External Services
      if (servicesState is GetAllServicesByWebIdLoaded) {
        final list =
            servicesState.response.result
                ?.where((s) => !(s.service?.pkgName?.contains('باقة') ?? false))
                .toList() ??
            [];
        hasServices = list.isNotEmpty;
      }

      // لو مفيش أي بيانات خدمات، نفتح تبويب "الاضافات"
      if (!hasPackages && !hasServices) {
        setState(() {
          selectedIndex = 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColorsManager.scaffoldBGColor,

      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColorsManager.primaryColor,
        onPressed: () {},
        child: CartButton(),
      ),

      body: SafeArea(
        child: Column(
          children: [
            const SubAppBar(title: "ماذا تريد؟"),
            CustomTabBar(
              listOfTitles: ['خدماتي', 'الاضافات'],
              onTabChanged: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              selectedIndex: selectedIndex,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: selectedIndex == 0 ? Services() : AllServices(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
