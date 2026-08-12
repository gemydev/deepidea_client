import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../core/utils/routes_manager/routes_manager.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../home/presentation/cubits/get_all_services_by_web_id/get_all_services_by_web_id_cubit.dart';
import '../../../home/presentation/widgets/external_service.dart';
import '../widgets/empty_state.dart';

class AllServices extends StatefulWidget {
  const AllServices({super.key});

  @override
  State<AllServices> createState() => _AllServicesState();
}

class _AllServicesState extends State<AllServices> {
  late final GetAllServicesByWebIdCubit getAllServicesByWebIdCubit;

  @override
  void initState() {
    super.initState();
    getAllServicesByWebIdCubit = sl<GetAllServicesByWebIdCubit>()
      ..getAllServicesByWebId();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getAllServicesByWebIdCubit,
      child: Scaffold(
        backgroundColor: CustomColorsManager.scaffoldBGColor,
        body: SafeArea(
          child: Column(
            children: [
              // const SubAppBar(title: "كل الخدمات"),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await getAllServicesByWebIdCubit.getAllServicesByWebId();
                    },
                    child:
                        BlocBuilder<
                          GetAllServicesByWebIdCubit,
                          GetAllServicesByWebIdState
                        >(
                          builder: (context, state) {
                            if (state is GetAllServicesByWebIdLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is GetAllServicesByWebIdError) {
                              return const EmptyStateWidget(
                                message: 'حدث خطأ أثناء تحميل الخدمات.',
                              );
                            } else if (state is GetAllServicesByWebIdLoaded) {
                              // 🟡 فلترة الخدمات: استبعاد أي خدمة تحتوي على كلمة "باقة"
                              final services = (state.response.result ?? [])
                                  .where((service) {
                                    final name =
                                        service.service!.pkgName?.toString() ??
                                        '';
                                    return !name.contains('باقة');
                                  })
                                  .toList();

                              if (services.isEmpty) {
                                return const EmptyStateWidget(
                                  message: 'لا توجد خدمات متاحة حالياً.',
                                );
                              }

                              return ListView.separated(
                                itemCount: services.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 8),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.serviceDetails,
                                        arguments: [
                                          false,
                                          true,
                                          services[index],
                                        ],
                                      );
                                    },
                                    child: ExternalService(
                                      withPrice: true,
                                      fromAddition: true,
                                      withDetailsAndOrderService: true,
                                      service: services[index],
                                    ),
                                  );
                                },
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
