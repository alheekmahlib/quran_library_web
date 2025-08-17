import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../widgets/code_block.dart';
import 'base_section_page.dart';

class AudioSurahPlaybackSection extends BaseSectionPage {
  const AudioSurahPlaybackSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle('surah_audio_playback'.tr),
        const Gap(16),
        buildParagraph('audio_enhanced_description'.tr),
        const Gap(24),
        buildSubtitle('surah_audio_playback'.tr),
        const Gap(16),
        const CodeBlock(
          code: '''/// تشغيل سورة كاملة من البداية حتى النهاية
/// Play a complete surah from beginning to end
await QuranLibrary().playSurah(surahNumber: 1); // الفاتحة
await QuranLibrary().playSurah(surahNumber: 2); // البقرة

/// الانتقال للسورة التالية وتشغيلها
/// Move to next surah and play it
await QuranLibrary().seekToNextSurah();

/// الانتقال للسورة السابقة وتشغيلها
/// Move to previous surah and play it
await QuranLibrary().seekToPreviousSurah();''',
          language: 'dart',
        ),
        const Gap(16),
        buildNote(null, 'surah_audio_control_note'.tr),
      ],
    );
  }
}
