import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../widgets/code_block.dart';
import 'base_section_page.dart';

class SurahDownloadManagementSection extends BaseSectionPage {
  const SurahDownloadManagementSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle('download_management'),
        const Gap(24),
        buildSubtitle('download_management'),
        const Gap(16),
        const CodeBlock(
          code: '''/// بدء تحميل سورة للتشغيل دون اتصال
/// Start downloading a surah for offline playback
await QuranLibrary().startDownloadSurah(surahNumber: 1);

/// إلغاء التحميل الجاري
/// Cancel ongoing download
QuranLibrary().cancelDownloadSurah();''',
          language: 'dart',
        ),
      ],
    );
  }
}
