import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../widgets/code_block.dart';
import 'base_section_page.dart';

class UtilityFunctionsSection extends BaseSectionPage {
  const UtilityFunctionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle('utility_functions'),
        const Gap(16),
        buildParagraph('utils_enhanced_description'),
        const Gap(24),
        buildSubtitle('getting_all_quran_data'),
        const Gap(12),
        CodeBlock(
          language: 'dart',
          code: '''final jozzs = QuranLibrary.allJoz;
final hizbs = QuranLibrary.allHizb;
final surahs = QuranLibrary.getAllSurahs();
final ayahsOnPage = QuranLibrary().getAyahsByPage();

/// [getSurahInfo] تتيح لك الحصول على سورة مع جميع بياناتها عند تمرير رقم السورة لها.
///
/// [getSurahInfo] let's you get a Surah with all its data when you pass Surah number
final surah = QuranLibrary().getSurahInfo(1);''',
        ),
        const Gap(16),
        buildNote(null, 'utility_functions_note'),
      ],
    );
  }
}
