import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../constants/app_constants.dart';
import '../../constants/app_theme.dart';
import 'base_section_page.dart';

class WhatIsQuranLibrarySection extends BaseSectionPage {
  const WhatIsQuranLibrarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle('what_is_quran_library'.tr),
        const Gap(24),

        // Logo and banner
        Center(
          child: Column(
            children: [
              // Logo
              Image.network(
                AppConstants.libraryLogoUrl,
                height: 150,
                width: 150,
              ),
              const Gap(16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryBlue.withValues(alpha: 0.1),
                      AppTheme.arabicGreen.withValues(alpha: 0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: buildTitle('library_subtitle'.tr),
              ),
            ],
          ),
        ),

        const Gap(32),

        buildParagraph('library_description'.tr),

        const Gap(16),

        buildParagraph('library_features'.tr),

        const Gap(24),

        buildFeaturesList([
          'feature_1'.tr,
          'feature_2'.tr,
          'feature_3'.tr,
          'feature_4'.tr,
          'feature_5'.tr,
          'feature_6'.tr,
          'feature_7'.tr,
          'feature_8'.tr,
        ], 'main_features'.tr),

        const Gap(32),

        buildNote(),
      ],
    );
  }
}
