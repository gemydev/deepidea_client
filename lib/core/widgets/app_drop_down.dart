import 'package:remotely/core/utils/color_manager/color_manager.dart';
import 'package:remotely/core/utils/style_manager/style_manager.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class AppDropdown extends StatefulWidget {
  const AppDropdown({
    super.key,
    required this.options,
    required this.hint,
    this.header,
    this.borderColor,
    this.buttonColor,
    this.onChanged,
    this.icon,
    this.value,
    this.withRiyalSign = false,
    this.searchable = false,
    this.searchHint = 'ابحث...',
  });

  final List<String> options;
  final String hint;
  final String? header;
  final String? value;
  final Color? borderColor;
  final Color? buttonColor;
  final ValueChanged<String>? onChanged;
  final Widget? icon;
  final bool withRiyalSign;

  /// Opens the options in a bottom sheet with a search field instead of a plain menu.
  final bool searchable;
  final String searchHint;

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  String? selectedValue;

  @override
  void initState() {
    selectedValue = widget.value;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AppDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      selectedValue = widget.value;
    }
    if (selectedValue != null && !widget.options.contains(selectedValue)) {
      selectedValue = null;
    }
  }

  void _select(String value) {
    widget.onChanged!(value);
    setState(() {
      selectedValue = value;
    });
  }

  Future<void> _openSearchSheet() async {
    final picked = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      backgroundColor: CustomColorsManager.white,
      isScrollControlled: true,
      builder: (_) => _SearchableOptionsSheet(
        title: widget.header ?? widget.hint,
        options: widget.options,
        selected: selectedValue,
        searchHint: widget.searchHint,
      ),
    );
    if (picked != null) _select(picked);
  }

  Widget _buildSearchableField(bool enabled) {
    return InkWell(
      onTap: enabled ? _openSearchSheet : null,
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        height: 48,
        child: Row(
          children: [
            Expanded(
              child: selectedValue == null
                  ? CustomText(widget.hint, style: CustomStyleManger.normalText)
                  : CustomText(
                      selectedValue!,
                      style: CustomStyleManger.normalText.copyWith(
                        fontSize: 13,
                        color: CustomColorsManager.mainTextColor,
                      ),
                    ),
            ),
            IconTheme(
              data: IconThemeData(color: enabled ? Colors.grey.shade700 : Colors.grey.shade400),
              child: widget.icon ?? const Icon(Icons.keyboard_arrow_down_rounded),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onChanged != null && widget.options.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: widget.buttonColor ?? CustomColorsManager.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: widget.borderColor ?? CustomColorsManager.lightTextColor),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: widget.searchable
              ? _buildSearchableField(enabled)
              : DropdownButton<String>(
                  hint: CustomText(widget.hint, style: CustomStyleManger.normalText),
                  value: selectedValue,
                  isExpanded: true,
                  underline: const SizedBox(),
                  dropdownColor: CustomColorsManager.white,
                  icon: widget.icon ?? const Icon(Icons.keyboard_arrow_down_rounded),
                  onChanged: enabled
                      ? (String? newValue) {
                          if (newValue == null) return;
                          _select(newValue);
                        }
                      : null,
                  items: widget.options.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: CustomText(
                        value,
                        style: CustomStyleManger.normalText.copyWith(
                          fontSize: 13,
                          color: CustomColorsManager.mainTextColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),
        ),
      ],
    );
  }
}

class _SearchableOptionsSheet extends StatefulWidget {
  const _SearchableOptionsSheet({required this.title, required this.options, required this.searchHint, this.selected});

  final String title;
  final List<String> options;
  final String searchHint;
  final String? selected;

  @override
  State<_SearchableOptionsSheet> createState() => _SearchableOptionsSheetState();
}

class _SearchableOptionsSheetState extends State<_SearchableOptionsSheet> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Makes Arabic/English matching forgiving: case, diacritics and letter variants.
  static String _normalize(String input) {
    return input
        .toLowerCase()
        .replaceAll(RegExp('[\u064B-\u0652\u0640]'), '')
        .replaceAll(RegExp('[أإآٱ]'), 'ا')
        .replaceAll('ة', 'ه')
        .replaceAll('ى', 'ي')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  @override
  Widget build(BuildContext context) {
    final normalizedQuery = _normalize(_query);
    final results = normalizedQuery.isEmpty
        ? widget.options
        : widget.options.where((o) => _normalize(o).contains(normalizedQuery)).toList();

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.75),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 12),
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: CustomText(
                widget.title,
                style: CustomStyleManger.normalText.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: CustomColorsManager.mainTextColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _searchController,
                autofocus: true,
                onChanged: (value) => setState(() => _query = value),
                decoration: InputDecoration(
                  hintText: widget.searchHint,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _query.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _query = '');
                          },
                        ),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: CustomColorsManager.lightTextColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: CustomColorsManager.lightTextColor),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: results.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Center(child: CustomText('لا توجد نتائج', style: CustomStyleManger.normalText)),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(bottom: 16),
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        final option = results[index];
                        final isSelected = option == widget.selected;
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                          title: CustomText(
                            option,
                            style: CustomStyleManger.normalText.copyWith(
                              fontSize: 13,
                              color: CustomColorsManager.mainTextColor,
                              fontWeight: isSelected ? FontWeight.w600 : null,
                            ),
                          ),
                          trailing: isSelected ? const Icon(Icons.check, size: 20) : null,
                          onTap: () => Navigator.of(context).pop(option),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
