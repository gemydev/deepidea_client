import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_text.dart';
import 'package:remotely/features/support/presentation/widgets/sub_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container/injection_container.dart';
import '../../../cart/data/models/responses/get_invoices_and_packages_response.dart';
import '../../../cart/presentation/cubit/get_invoices_and_packages/get_invoices_and_packages_cubit.dart';

class Invoices extends StatefulWidget {
  const Invoices({super.key});

  @override
  State<Invoices> createState() => _InvoicesState();
}

class _InvoicesState extends State<Invoices> {
  GetInvoicesAndPackagesCubit getInvoicesAndPackagesCubit = sl<GetInvoicesAndPackagesCubit>();
  @override
  void initState() {
    super.initState();
    getInvoicesAndPackagesCubit.getInvoicesAndPackages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColorsManager.scaffoldBGColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SubAppBar(title: "الفواتير"),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                child: BlocBuilder<GetInvoicesAndPackagesCubit, GetInvoicesAndPackagesState>(
                  bloc: getInvoicesAndPackagesCubit,
                  builder: (context, state) {
                    if (state is GetInvoicesAndPackagesLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is GetInvoicesAndPackagesError) {
                      return Center(
                        child: CustomText(
                          "حدث خطأ أثناء تحميل الفواتير",
                          style: CustomStyleManger.normalText,
                        ),
                      );
                    } else if (state is GetInvoicesAndPackagesLoaded) {
                      final invoices = state.getInvoicesAndPackagesResponse.info ?? [];

                      if (invoices.isEmpty) {
                        return Center(
                          child: CustomText("لا توجد فواتير", style: CustomStyleManger.normalText),
                        );
                      }

                      return ListView.separated(
                        itemCount: invoices.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 15),
                        itemBuilder: (context, index) {
                          final invoice = invoices[index];
                          return InvoiceItem(info: invoice);
                        },
                      );
                    }

                    return const Center(child: CustomText("جار التحميل ..."));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InvoiceItem extends StatelessWidget {
  final Info info;

  const InvoiceItem({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: CustomColorsManager.white),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    info.name ?? "بدون اسم",
                    style: CustomStyleManger.normalText.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  CustomText(
                    "رقم الفاتورة: ${info.invoiceId ?? "-"}",
                    style: CustomStyleManger.normalText.copyWith(fontSize: 16),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    CustomText(
                      "عدد الخدمات:",
                      style: CustomStyleManger.normalText.copyWith(fontSize: 16),
                    ),
                    const SizedBox(width: 5),
                    CustomText(
                      "${info.packages?.length ?? 0}",
                      style: CustomStyleManger.normalText.copyWith(
                        color: CustomColorsManager.green,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
