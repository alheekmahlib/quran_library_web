import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_theme.dart';
import '../controllers/language_controller.dart';

class LanguageDropdown extends StatelessWidget {
  const LanguageDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.find<LanguageController>();

    return Obx(() => SizedBox(
          width: 210,
          height: 40,
          child: CustomDropdown<LanguageModel>(
            items: languageController.languages,
            initialItem: languageController.currentLanguageModel,
            closedHeaderPadding:
                EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            onChanged: (LanguageModel? language) {
              if (language != null) {
                languageController.changeLanguage(language.code);
              }
            },
            decoration: CustomDropdownDecoration(
              closedFillColor: Colors.transparent,
              expandedFillColor: AppTheme.cardColor,
              closedBorder: Border.all(
                color: AppTheme.textSecondary.withValues(alpha: .3),
                width: 1,
              ),
              expandedBorder: Border.all(
                color: AppTheme.primaryBlue.withValues(alpha: 0.5),
                width: 1,
              ),
              closedBorderRadius: BorderRadius.circular(8),
              expandedBorderRadius: BorderRadius.circular(8),
            ),
            listItemBuilder: (context, item, isSelected, onItemSelect) {
              return _buildDropdownItem(item, isSelected, onItemSelect);
            },
            headerBuilder: (context, selectedItem, enabled) {
              return _buildHeader(selectedItem);
            },
          ),
        ));
  }

  Widget _buildHeader(LanguageModel selectedItem) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            selectedItem.flag,
            style: const TextStyle(fontSize: 16),
          ),
          const Gap(8),
          Text(
            selectedItem.name,
            style: GoogleFonts.cairo(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownItem(
    LanguageModel item,
    bool isSelected,
    VoidCallback onItemSelect,
  ) {
    return InkWell(
      onTap: onItemSelect,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Text(
              item.flag,
              style: const TextStyle(fontSize: 16),
            ),
            const Gap(12),
            Text(
              item.name,
              style: GoogleFonts.cairo(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? AppTheme.primaryBlue : AppTheme.textPrimary,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check,
                size: 16,
                color: AppTheme.primaryBlue,
              ),
          ],
        ),
      ),
    );
  }
}
