import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../home/presentation/cubits/get_packages/get_packages_cubit.dart';
import '../../../home/presentation/widgets/aap_service.dart';
import '../widgets/empty_state.dart';

class Services extends StatefulWidget {
  const Services({super.key});

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  late final GetPackagesCubit getPackagesCubit;

  @override
  void initState() {
    super.initState();
    getPackagesCubit = sl<GetPackagesCubit>()..getPackages();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getPackagesCubit,
      child: Scaffold(
        backgroundColor: CustomColorsManager.scaffoldBGColor,
        body: SafeArea(
          child: Column(
            children: [
              // const SubAppBar(title: "خدماتي"),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await getPackagesCubit.getPackages();
                    },
                    child: BlocBuilder<GetPackagesCubit, GetPackagesState>(
                      builder: (context, state) {
                        if (state is GetPackagesLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is GetPackagesError) {
                          return EmptyStateWidget(
                            message: 'لا توجد خدمات متاحة لهذا لعميل',
                          );
                        } else if (state is GetPackagesLoaded) {
                          if (state.response.info == null ||
                              state.response.info!.isEmpty) {
                            return EmptyStateWidget(
                              message: state.response.msg.toString(),
                            );
                          }
                          final services = state.response.info ?? [];

                          return ListView.separated(
                            itemCount: services.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 8),
                            itemBuilder: (context, index) {
                              return AAPService(
                                withPrice: false,
                                fromAddition: true,
                                withDetailsAndOrderService: true,
                                service: services[index],
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
