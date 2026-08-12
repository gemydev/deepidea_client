import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/helpers/snakbar_manager.dart';
import '../../../../core/utils/color_manager/color_manager.dart';
import '../../../../core/utils/style_manager/style_manager.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../shared_widgets/section_title.dart';
import '../../data/models/responses/ticket_faq.dart';
import '../cubits/get_ticket_faq/get_ticket_faq_cubit.dart';

class TicketFaqSection extends StatelessWidget {
  const TicketFaqSection({super.key, required this.cubit});

  final GetTicketFaqCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTicketFaqCubit, GetTicketFaqState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is GetTicketFaqLoading) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is GetTicketFaqError) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: CustomText(
              state.message,
              style: CustomStyleManger.normalText.copyWith(color: CustomColorsManager.red),
            ),
          );
        }

        if (state is! GetTicketFaqLoaded || state.categories.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle('الأسئلة الشائعة'),
            const SizedBox(height: 12),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: state.categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  final id = category.categoryId?.toInt();
                  final isSelected = id != null && id == state.selectedCategoryId;
                  return FilterChip(
                    label: Text(category.categoryName ?? ''),
                    selected: isSelected,
                    onSelected: id == null ? null : (_) => cubit.selectCategory(id),
                    selectedColor: CustomColorsManager.primaryColor.withValues(alpha: 0.15),
                    checkmarkColor: CustomColorsManager.primaryColor,
                    labelStyle: CustomStyleManger.normalText.copyWith(
                      fontSize: 14,
                      color: isSelected
                          ? CustomColorsManager.primaryColor
                          : CustomColorsManager.mainTextColor,
                    ),
                    side: BorderSide(
                      color: isSelected
                          ? CustomColorsManager.primaryColor
                          : CustomColorsManager.unSelectedBorderColor,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            if (state.isLoadingFaqs)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (state.faqs.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomText(
                  'لا توجد أسئلة في هذا التصنيف.',
                  style: CustomStyleManger.normalText.copyWith(
                    color: CustomColorsManager.lightTextColor,
                  ),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    for (int i = 0; i < state.faqs.length; i++) ...[
                      if (i > 0) const SizedBox(height: 8),
                      _FaqExpansionTile(faq: state.faqs[i]),
                    ],
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}

class _FaqExpansionTile extends StatelessWidget {
  const _FaqExpansionTile({required this.faq});

  final TicketFaq faq;

  Future<void> _openLink(String? raw) async {
    final link = raw?.trim();
    if (link == null || link.isEmpty) return;

    final uri = Uri.tryParse(link);
    if (uri == null || !uri.hasScheme) {
      AppSnackBar.error('الرابط غير صالح');
      return;
    }
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      AppSnackBar.error('تعذر فتح الرابط');
    }
  }

  bool _hasLaunchableLink(String? raw) {
    final link = raw?.trim();
    if (link == null || link.isEmpty) return false;
    final uri = Uri.tryParse(link);
    return uri != null && uri.hasScheme;
  }

  @override
  Widget build(BuildContext context) {
    final details = faq.details?.trim();
    final hasYoutube = _hasLaunchableLink(faq.youtubeLink);
    final hasPdf = _hasLaunchableLink(faq.pdfLink);

    return Container(
      decoration: BoxDecoration(
        color: CustomColorsManager.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: CustomColorsManager.unSelectedBorderColor),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          title: CustomText(
            faq.question ?? '',
            style: CustomStyleManger.normalText.copyWith(fontWeight: FontWeight.w600),
          ),
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: CustomText(
                faq.answer ?? '',
                style: CustomStyleManger.normalText.copyWith(
                  color: CustomColorsManager.mainTextColor,
                  height: 1.5,
                ),
              ),
            ),
            if (details != null && details.isNotEmpty) ...[
              const SizedBox(height: 8),
              CustomText(
                details,
                style: CustomStyleManger.normalText.copyWith(
                  color: CustomColorsManager.lightTextColor,
                  fontSize: 14,
                ),
              ),
            ],
            if (hasYoutube || hasPdf) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (hasYoutube)
                    TextButton.icon(
                      onPressed: () => _openLink(faq.youtubeLink),
                      icon: const Icon(Icons.play_circle_outline, size: 20),
                      label: const Text('فيديو'),
                    ),
                  if (hasPdf)
                    TextButton.icon(
                      onPressed: () => _openLink(faq.pdfLink),
                      icon: const Icon(Icons.picture_as_pdf_outlined, size: 20),
                      label: const Text('PDF'),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
