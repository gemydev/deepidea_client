import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/helpers/preferences_manager.dart';
import '../../../../core/helpers/snakbar_manager.dart';
import '../../../../shared_widgets/ticket_created_success_dialog.dart';
import '../../../../core/utils/assets_manager/assets_manager.dart';
import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../core/utils/style_manager/style_manager.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../shared_widgets/detail_app_bar.dart';
import '../../../../shared_widgets/labeled_form_field.dart';
import '../../../../core/widgets/app_drop_down.dart';
import '../../../../injection_container/injection_container.dart';
import '../../../home/presentation/cubits/upload_files/upload_files_cubit.dart';
import '../../data/models/requests/submit_ticket_with_files_request.dart';
import '../cubits/get_ticket_categories/get_ticket_categories_cubit.dart';
import '../cubits/submit_ticket_with_files/submit_ticket_with_files_cubit.dart';
import '../widgets/add_files.dart';

class CreateTicketOrder extends StatefulWidget {
  const CreateTicketOrder({super.key});

  @override
  State<CreateTicketOrder> createState() => _CreateTicketOrderState();
}

class _CreateTicketOrderState extends State<CreateTicketOrder> {
  final _formKey = GlobalKey<FormState>();

  final getTicketCategoriesCubit = sl<GetTicketCategoriesCubit>();
  final submitTicketWithFilesCubit = sl<SubmitTicketWithFilesCubit>();
  final uploadFilesCubit = sl<UploadFilesCubit>();

  final TextEditingController msgController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();

  int? parentCategoryId;
  int? categoryId;

  @override
  void initState() {
    super.initState();
    getTicketCategoriesCubit.loadParentCategories();
  }

  @override
  void dispose() {
    uploadFilesCubit.clearUploadedFiles();
    msgController.dispose();
    subjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColorsManager.scaffoldBGColor,
      body: SafeArea(
        child: BlocConsumer<SubmitTicketWithFilesCubit, SubmitTicketWithFilesState>(
          bloc: submitTicketWithFilesCubit,
          listener: (context, state) {
            if (state is SubmitTicketWithFilesLoaded) {
              uploadFilesCubit.clearUploadedFiles();
              showTicketCreatedSuccessDialog();
            } else if (state is SubmitTicketWithFilesError) {
              AppSnackBar.error("حدث خطأ أثناء إنشاء الطلب");
            }
          },
          builder: (context, state) {
            final isLoading = state is SubmitTicketWithFilesLoading;

            return Column(
              children: [
                DetailAppBar(
                  title: 'انشاء تذكرة جديدة',
                  onBack: () {
                    uploadFilesCubit.clearUploadedFiles();
                    Navigator.pop(context);
                  },
                  backFilled: true,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      color: CustomColorsManager.white,
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LabeledFormField(
                              label: "عنوان التذكرة",
                              child: CustomTextFormField(
                                hintText: "أدخل عنوان التذكرة",
                                controller: subjectController,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "برجاء إدخال عنوان التذكرة";
                                  }
                                  if (value.length < 3) {
                                    return "عنوان التذكرة قصير جدًا";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 25),
                            BlocConsumer<GetTicketCategoriesCubit, GetTicketCategoriesState>(
                              bloc: getTicketCategoriesCubit,
                              listener: (context, state) {
                                if (state is GetTicketCategoriesError) {
                                  AppSnackBar.error('تعذر تحميل تصنيفات التذكرة');
                                }
                              },
                              builder: (context, state) {
                                if (state is GetTicketCategoriesLoading) {
                                  return const Center(child: CircularProgressIndicator());
                                }

                                if (state is GetTicketCategoriesLoaded) {
                                  final parentCategories = state.parentCategories
                                      .where((e) => (e.categoryName ?? '').isNotEmpty)
                                      .toList();
                                  final parentOptions = parentCategories
                                      .map((e) => e.categoryName!)
                                      .toList();

                                  final subCategories = state.subCategories
                                      .where((e) => (e.categoryName ?? '').isNotEmpty)
                                      .toList();
                                  final subOptions = subCategories
                                      .map((e) => e.categoryName!)
                                      .toList();

                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      FormField<int>(
                                        validator: (_) {
                                          if (parentCategoryId == null) {
                                            return 'برجاء اختيار القسم الرئيسي';
                                          }
                                          return null;
                                        },
                                        builder: (fieldState) {
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              LabeledFormField(
                                                label: 'القسم الرئيسي',
                                                child: AppDropdown(
                                                  options: parentOptions,
                                                  hint: 'اختر القسم الرئيسي',
                                                  onChanged: (value) {
                                                    final index = parentOptions.indexOf(value);
                                                    if (index < 0) return;
                                                    final parent = parentCategories[index];
                                                    final parentId = parent.categoryId?.toInt();
                                                    if (parentId == null) return;

                                                    setState(() {
                                                      parentCategoryId = parentId;
                                                      categoryId = null;
                                                    });
                                                    fieldState.didChange(parentCategoryId);
                                                    getTicketCategoriesCubit.loadSubCategories(
                                                      parentId,
                                                    );
                                                  },
                                                ),
                                              ),
                                              if (fieldState.hasError)
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 8),
                                                  child: Text(
                                                    fieldState.errorText!,
                                                    style: const TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 25),
                                      if (state.isLoadingSubCategories)
                                        const Padding(
                                          padding: EdgeInsets.only(bottom: 12),
                                          child: Center(
                                            child: SizedBox(
                                              width: 28,
                                              height: 28,
                                              child: CircularProgressIndicator(strokeWidth: 2),
                                            ),
                                          ),
                                        ),
                                      FormField<int>(
                                        validator: (_) {
                                          if (categoryId == null) {
                                            return 'برجاء اختيار نوع التذكرة';
                                          }
                                          return null;
                                        },
                                        builder: (fieldState) {
                                          final subEnabled =
                                              parentCategoryId != null &&
                                              !state.isLoadingSubCategories &&
                                              subOptions.isNotEmpty;

                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              LabeledFormField(
                                                label: 'نوع التذكرة',
                                                child: AppDropdown(
                                                  key: ValueKey<int?>(parentCategoryId),
                                                  options: subEnabled ? subOptions : const [],
                                                  hint: parentCategoryId == null
                                                      ? 'اختر القسم الرئيسي أولاً'
                                                      : state.isLoadingSubCategories
                                                      ? 'جاري تحميل الأنواع...'
                                                      : subOptions.isEmpty
                                                      ? 'لا توجد أنواع لهذا القسم'
                                                      : 'اختر نوع التذكرة',
                                                  onChanged: subEnabled
                                                      ? (value) {
                                                          final index = subOptions.indexOf(value);
                                                          if (index < 0) return;
                                                          setState(() {
                                                            categoryId = subCategories[index]
                                                                .categoryId!
                                                                .toInt();
                                                          });
                                                          fieldState.didChange(categoryId);
                                                        }
                                                      : null,
                                                ),
                                              ),
                                              if (fieldState.hasError)
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 8),
                                                  child: Text(
                                                    fieldState.errorText!,
                                                    style: const TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                }

                                return const SizedBox.shrink();
                              },
                            ),
                            const SizedBox(height: 25),
                            LabeledFormField(
                              label: "وصف التذكرة",
                              child: CustomTextFormField(
                                hintText: "ادخل المشكلة بوضوح..",
                                controller: msgController,
                                maxLines: 5,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "برجاء إدخال وصف التذكرة";
                                  }
                                  if (value.length < 10) {
                                    return "وصف التذكرة يجب أن يكون أطول";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 25),
                            AddFilesContainer(),
                            BlocBuilder<UploadFilesCubit, UploadFilesState>(
                              bloc: uploadFilesCubit,
                              builder: (context, state) {
                                final fileNames = uploadFilesCubit.uploadedFileNames;
                                if (fileNames.isEmpty) return const SizedBox.shrink();
                                return Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        'الملفات المرفوعة',
                                        style: CustomStyleManger.normalText.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: CustomColorsManager.mainTextColor,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      ...fileNames.asMap().entries.map(
                                        (entry) => Padding(
                                          padding: const EdgeInsets.only(bottom: 4),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.attach_file,
                                                size: 18,
                                                color: CustomColorsManager.primaryColor,
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: CustomText(
                                                  entry.value,
                                                  style: CustomStyleManger.normalText.copyWith(
                                                    fontSize: 14,
                                                    color: CustomColorsManager.black,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  uploadFilesCubit.removeUploadedFileAt(entry.key);
                                                },
                                                icon: const Icon(Icons.close),
                                                iconSize: 20,
                                                color: CustomColorsManager.appRed,
                                                padding: EdgeInsets.zero,
                                                constraints: const BoxConstraints(
                                                  minWidth: 32,
                                                  minHeight: 32,
                                                ),
                                                tooltip: 'حذف الملف',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 25),
                            CustomButton(
                              text: isLoading ? "جاري الإرسال..." : "ارسال التذكرة",
                              textColor: CustomColorsManager.white,
                              fontSize: 15,
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                if (categoryId == null) {
                                  AppSnackBar.error('برجاء اختيار نوع التذكرة');
                                  return;
                                }

                                final uploadedIds = uploadFilesCubit.uploadedFileIds;

                                final request = TicketSubmissionRequest(
                                  msg: msgController.text.trim(),
                                  fileIds: uploadedIds.isEmpty ? null : uploadedIds,
                                  subject: subjectController.text.trim(),
                                  userId:
                                      TpPreferencesManager.retrieveString(
                                        TpPreferencesManager.userId,
                                      ) ??
                                      "",
                                  categoryId: categoryId,
                                );
                                debugPrint(
                                  'TicketSubmissionRequest: ${request.toJson()}',
                                );

                                submitTicketWithFilesCubit.submitTicketWithFiles(
                                  request,
                                );
                              },
                              child: isLoading
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        color: CustomColorsManager.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset(
                                          CustomAssetsManager.ticket2,
                                          width: 24,
                                          height: 24,
                                          colorFilter: const ColorFilter.mode(
                                            CustomColorsManager.white,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        CustomText(
                                          "ارسال التذكرة",
                                          style: CustomStyleManger.normalText.copyWith(
                                            color: CustomColorsManager.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
