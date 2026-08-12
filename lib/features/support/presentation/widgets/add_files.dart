import 'dart:io';

import 'package:remotely/core/utils/assets_manager/assets_manager.dart';
import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:remotely/core/widgets/custom_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../injection_container/injection_container.dart';
import '../../../home/presentation/cubits/upload_files/upload_files_cubit.dart';

class AddFilesContainer extends StatefulWidget {
  const AddFilesContainer({super.key});

  @override
  State<AddFilesContainer> createState() => _AddFilesContainerState();
}

class _AddFilesContainerState extends State<AddFilesContainer> {
  File? _selectedFile;

  UploadFilesCubit uploadFilesCubit = sl<UploadFilesCubit>();

  Future<void> _pickFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx', 'xls', 'xlsx'],
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });

      uploadFilesCubit.uploadFiles(_selectedFile!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadFilesCubit, UploadFilesState>(
      bloc: uploadFilesCubit,
      listener: (context, state) {
        if (state is UploadFilesError) {
        } else if (state is UploadFilesLoaded) {
          setState(() => _selectedFile = null);
        }
      },
      builder: (context, state) {
        final isLoading = state is UploadFilesLoading;

        return InkWell(
          onTap: isLoading ? null : () => _pickFile(context),
          borderRadius: BorderRadius.circular(16),
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(16),
            dashPattern: const [6, 4],
            color: CustomColorsManager.unSelectedBorderColor,
            strokeWidth: 1.5,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          CustomAssetsManager.uploadSvg,
                          width: 48,
                          height: 48,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 12),
                        CustomText(
                          uploadFilesCubit.uploadedFileNames.isNotEmpty
                              ? "اضغط لإضافة ملف آخر"
                              : _selectedFile != null
                                  ? "جاري الرفع..."
                                  : "اسحب الملفات من هنا",
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: CustomStyleManger.normalText.copyWith(
                            fontSize: 15,
                            color: CustomColorsManager.black,
                          ),
                        ),
                        const SizedBox(height: 6),
                        CustomText(
                          "الحد الاقصى : 10 ميجابايت (pdf,jpg,png)",
                          textAlign: TextAlign.center,
                          style: CustomStyleManger.normalText.copyWith(
                            fontSize: 13,
                            color: CustomColorsManager.primaryColor,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
