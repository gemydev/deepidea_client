import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/widgets/custom_button.dart';
import 'package:remotely/core/widgets/custom_text_form_field.dart';
import 'package:remotely/features/home/data/models/requests/submit_sales_delivery_request.dart';
import 'package:remotely/features/home/data/models/responses/get_package_response.dart';
import 'package:remotely/features/home/presentation/cubits/get_packages/get_packages_cubit.dart';
import 'package:remotely/features/home/presentation/cubits/submit_sales_delivery/submit_sales_delivery_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/helpers/snakbar_manager.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../support/presentation/widgets/add_files.dart';
import '../../../support/presentation/widgets/sub_app_bar.dart';
import '../cubits/upload_files/upload_files_cubit.dart';

class OrderService extends StatefulWidget {
  const OrderService({super.key});

  @override
  State<OrderService> createState() => _OrderServiceState();
}

class _OrderServiceState extends State<OrderService> {
  final SubmitSalesDeliveryCubit submitSalesDeliveryCubit = sl<SubmitSalesDeliveryCubit>();

  final TextEditingController quantityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late final ServicePackage service;

  @override
  void initState() {
    super.initState();
    service = Get.arguments[0];
  }

  @override
  void dispose() {
    quantityController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  bool _canPop() {
    return submitSalesDeliveryCubit.state is! SubmitSalesDeliveryLoading;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _canPop(),
      child: Scaffold(
        backgroundColor: CustomColorsManager.scaffoldBGColor,
        body: SafeArea(
          child: BlocConsumer<SubmitSalesDeliveryCubit, SubmitSalesDeliveryState>(
            bloc: submitSalesDeliveryCubit,
            listener: (context, state) {
              /// ✅ Success
              if (state is SubmitSalesDeliveryLoaded) {
                AppSnackBar.success(state.response.message.toString());
                sl<GetPackagesCubit>().getPackages();
                Get.back();
              }

              /// ❌ Error
              if (state is SubmitSalesDeliveryError) {
                AppSnackBar.error(state.message);
              }
            },
            builder: (context, state) {
              final bool isLoading = state is SubmitSalesDeliveryLoading;

              return Column(
                children: [
                  /// ===== App Bar =====
                  SubAppBar(
                    title: "طلب أمر عمل",
                    onTap: () {
                      /// 🚫 منع زر الرجوع العلوي أثناء الإرسال
                      if (!isLoading) {
                        Get.back();
                      } else {
                        AppSnackBar.warning("يرجى الانتظار حتى انتهاء إنشاء الطلب");
                      }
                    },
                  ),

                  /// ===== Body =====
                  Expanded(
                    child: SingleChildScrollView(
                      physics: isLoading
                          ? const NeverScrollableScrollPhysics()
                          : const BouncingScrollPhysics(),
                      child: Container(
                        color: CustomColorsManager.white,
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextFormField(
                                hintText: "الكمية",
                                controller: quantityController,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "الرجاء إدخال الكمية";
                                  }

                                  final n = int.tryParse(value);
                                  if (n == null) {
                                    return "الرجاء إدخال رقم صحيح";
                                  }

                                  if (n <= 0) {
                                    return "الكمية يجب أن تكون أكبر من صفر";
                                  }

                                  if (n > service.availableQty!.toInt()) {
                                    return "العدد المتاح هو ${service.availableQty}";
                                  }

                                  return null;
                                },
                              ),

                              const SizedBox(height: 25),

                              CustomTextFormField(
                                hintText: "الوصف",
                                maxLines: 5,
                                controller: descriptionController,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "الرجاء إدخال وصف الطلب";
                                  }

                                  if (value.trim().length < 5) {
                                    return "الوصف يجب أن يكون على الأقل 5 أحرف";
                                  }

                                  return null;
                                },
                              ),

                              const SizedBox(height: 25),

                              const AddFilesContainer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// ===== Submit Button =====
                  Container(
                    color: CustomColorsManager.white,
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    child: AbsorbPointer(
                      absorbing: isLoading,
                      child: CustomButton(
                        text: isLoading ? "جاري الإرسال..." : "إنشاء طلب",
                        textColor: CustomColorsManager.white,
                        fontSize: 20,
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) return;

                          final uploadCubit = sl<UploadFilesCubit>();

                          submitSalesDeliveryCubit.submitSalesDelivery(
                            SubmitSalesDeliveryRequest(
                              invoiceId: service.invoiceId!.toInt(),
                              packageId: service.packageId!.toInt(),
                              quantity: int.parse(quantityController.text),
                              description: descriptionController.text.trim(),
                              fileIds: uploadCubit.uploadedFileIds,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
