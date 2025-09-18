import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../widgets/code_block.dart';
import 'base_section_page.dart';

class TafsirSection extends BaseSectionPage {
  const TafsirSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle('tafsir'.tr),
        const Gap(16),
        buildSubtitle('important_note'.tr),
        const Gap(12),
        buildParagraph('tafsir_enhanced'.tr),
        const Gap(16),
        const CodeBlock(
          code: '''dependencies:
 ...
  drift_flutter: ^0.2.4
 ...''',
          language: 'yaml',
        ),
        const Gap(16),
        buildParagraph('tafsir_note'.tr),
        const Gap(24),
        buildSubtitle('tafsir_usage_example'.tr),
        const Gap(16),
        const CodeBlock(
          code: '''/// Show a popup menu to change the tafsir style.
/// إظهار قائمة منبثقة لتغيير نوع التفسير.
QuranLibrary().changeTafsirPopupMenu(TafsirStyle tafsirStyle, {int? pageNumber});

/// إغلاق قاعدة البيانات وإعادة تهيئتها (عادة عند تغيير التفسير).
/// Close and re-initialize the database (usually when changing the tafsir).
QuranLibrary().closeAndInitializeDatabase({int? pageNumber});

/// جلب التفسير الخاص بصفحة معينة من خلال رقم الصفحة.
/// Fetch tafsir for a specific page by its page number.
QuranLibrary().fetchTafsir({required int pageNumber});

/// التحقق إذا كان التفسير تم تحميله مسبقاً.
/// Check if the tafsir is already downloaded.
QuranLibrary().getTafsirDownloaded(int index);

/// الحصول على قائمة أسماء التفاسير والترجمات.
/// Get the list of tafsir and translation names.
QuranLibrary().tafsirAndTraslationCollection;

/// تغيير التفسير المختار عند الضغط على زر التبديل.
/// Change the selected tafsir when the switch button is pressed.
QuranLibrary().changeTafsirSwitch(int index, {int? pageNumber});

/// الحصول على قائمة بيانات التفاسير المتوفرة.
/// Get the list of available tafsir data.
QuranLibrary().tafsirList;

/// الحصول على قائمة الترجمات المتوفرة.
/// Get the list of available translations.
QuranLibrary().translationList;

/// جلب الترجمات من المصدر.
/// Fetch translations from the source.
QuranLibrary().fetchTranslation();

/// تحميل التفسير المحدد حسب الفهرس.
/// Download the tafsir by the given index.
QuranLibrary().tafsirDownload(int i);''',
          language: 'dart',
        ),
        const Gap(24),
        buildWarning(),
      ],
    );
  }
}
