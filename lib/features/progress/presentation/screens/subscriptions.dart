import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/features/home/data/models/requests/get_service_from_service_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/style_manager/style_manager.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../home/data/models/responses/get_registered_services_and_packages_response.dart';
import '../../../home/presentation/cubits/get_packages/get_packages_cubit.dart';
import '../../../home/presentation/cubits/get_registered_services_and_packages/get_registered_services_and_packages_cubit.dart';
import '../../../home/presentation/widgets/bottom_sheets/service_details.dart';
import '../../../support/presentation/widgets/sub_app_bar.dart';
import '../widgets/package_details.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({super.key});

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  late final GetRegisteredServicesAndPackagesCubit registeredCubit;
  late final GetPackagesCubit packagesCubit;

  @override
  void initState() {
    super.initState();
    registeredCubit = sl<GetRegisteredServicesAndPackagesCubit>();
    packagesCubit = sl<GetPackagesCubit>();

    registeredCubit.getRegisteredServicesAndPackages();
    packagesCubit.getPackages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColorsManager.scaffoldBGColor,
      body: SafeArea(
        child: Column(
          children: [
            const SubAppBar(title: "الاشتراكات"),
            Expanded(
              child:
                  BlocBuilder<
                    GetRegisteredServicesAndPackagesCubit,
                    GetRegisteredServicesAndPackagesState
                  >(
                    bloc: registeredCubit,
                    builder: (context, state) {
                      if (state is GetRegisteredServicesAndPackagesLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is GetRegisteredServicesAndPackagesError) {
                        return Center(
                          child: CustomText(
                            state.message,
                            style: CustomStyleManger.heading1.copyWith(
                              color: Colors.red,
                              fontSize: 16,
                            ),
                          ),
                        );
                      }

                      if (state is GetRegisteredServicesAndPackagesLoaded) {
                        final result = state.response.result;

                        final List<ServiceOrPackage> items = [
                          ...?result?.bundles,
                          ...?result?.services,
                        ];

                        if (items.isEmpty) {
                          return const Center(child: Text("لا توجد اشتراكات متاحة"));
                        }

                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: ListView.separated(
                            itemCount: items.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final item = items[index];

                              return SubscriptionItem(
                                bundleId: item.id.toString(),
                                invoiceId: item.invoiceId.toString(),
                                name: item.name ?? 'باقة',
                                image: item.images.isNotEmpty ? item.images.first : '',
                                isBundle: item.isBundle,
                                onServiceTap: (serviceId) {
                                  final service = items.firstWhere(
                                    (e) => !e.isBundle && e.id.toString() == serviceId,
                                    orElse: () => items.first,
                                  );

                                  showServiceDetailsBottomSheet(
                                    context,
                                    GetServiceFromServiceIdRequest(
                                      serviceId: service.id.toString(),
                                      invoiceId: service.invoiceId.toString(),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
