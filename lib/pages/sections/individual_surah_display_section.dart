import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../widgets/code_block.dart';
import 'base_section_page.dart';

class IndividualSurahDisplaySection extends BaseSectionPage {
  const IndividualSurahDisplaySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle('individual_surah_display'),
        const Gap(16),
        buildParagraph('individual_surah_enhanced'.tr),
        const Gap(16),
        CodeBlock(
          language: 'dart',
          code: '''/// For displaying a single surah with custom pagination
/// لعرض سورة واحدة مع تقسيم مخصص للصفحات
SurahDisplayScreen(
    /// رقم السورة المراد عرضها [surahNumber]
    /// [surahNumber] The surah number to display
    surahNumber: 1, // For Al-Fatihah - للفاتحة
    /// إذا تم توفيره فسيتم استدعاؤه عند تغيير صفحة السورة [onPageChanged]
    /// [onPageChanged] if provided it will be called when a surah page changed
    onPageChanged: (int pageIndex) => print("Surah page changed: \$pageIndex"),
    /// تمكين أو تعطيل النمط المظلم [isDark]
    /// [isDark] enable or disable dark mode
    isDark: false,
    /// تغيير نمط البسملة [basmalaStyle]
    /// [basmalaStyle] Change the style of Basmala
    basmalaStyle: BasmalaStyle(
        basmalaColor: Colors.black,
        basmalaWidth: 160.0,
        basmalaHeight: 30.0,
    ),
    /// تغيير نمط الشعار [bannerStyle]
    /// [bannerStyle] Change the style of banner
    bannerStyle: BannerStyle(
        isImage: false,
        bannerSvgHeight: 40.0,
        bannerSvgWidth: 150.0,
    ),
    /// and more options...
),''',
        ),
        const Gap(16),
        buildNote(null, 'individual_surah_note'),
      ],
    );
  }
}
