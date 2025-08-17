import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../widgets/code_block.dart';
import 'base_section_page.dart';

class FontStylesSection extends BaseSectionPage {
  const FontStylesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle('Font Styles - أنماط الخطوط'),
        const Gap(16),
        buildParagraph('font_styles'.tr),
        const Gap(24),
        buildSubtitle('Hafs Style - نمط حفص'),
        const Gap(12),
        buildParagraph('hafs_style'.tr),
        const Gap(16),
        const CodeBlock(
          code:
              '''/// [hafsStyle] هو النمط الافتراضي للقرآن، مما يضمن عرض جميع الأحرف الخاصة بشكل صحيح.
///
/// [hafsStyle] is the default style for Quran so all special characters will be rendered correctly
QuranLibrary().hafsStyle;''',
          language: 'dart',
        ),
        const Gap(24),
        buildSubtitle('Naskh Style - نمط النسخ'),
        const Gap(12),
        buildParagraph('naskh_style'.tr),
        const Gap(16),
        const CodeBlock(
          code: '''/// [naskhStyle] هو النمط الافتراضي للنصوص الآخرى.
///
/// [naskhStyle] is the default style for other text.
QuranLibrary().naskhStyle;''',
          language: 'dart',
        ),
        const Gap(16),
        buildNote(null,
            'Choose the appropriate font style based on your content type.\nاختر نمط الخط المناسب حسب نوع المحتوى.'),
      ],
    );
  }
}
