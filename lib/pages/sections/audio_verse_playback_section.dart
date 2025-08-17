import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../widgets/code_block.dart';
import 'base_section_page.dart';

class AudioVersePlaybackSection extends BaseSectionPage {
  const AudioVersePlaybackSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle('verse_audio_playback'.tr),
        const Gap(16),
        buildParagraph('audio_enhanced_description'.tr),
        const Gap(24),
        buildSubtitle('verse_audio_playback'.tr),
        const Gap(16),
        const CodeBlock(
          code: '''/// تشغيل آية أو مجموعة من الآيات بدءًا من آية محددة
/// Play a verse or group of verses starting from a specific verse
await QuranLibrary().playAyah(
  context: context,
  currentAyahUniqueNumber: 1, // رقم الآية الفريد
  playSingleAyah: true, // true لآية واحدة، false للاستمرار
);

/// الانتقال للآية التالية وتشغيلها
/// Move to next verse and play it
await QuranLibrary().seekNextAyah(
  context: context,
  currentAyahUniqueNumber: 5,
);

/// الانتقال للآية السابقة وتشغيلها
/// Move to previous verse and play it
await QuranLibrary().seekPreviousAyah(
  context: context,
  currentAyahUniqueNumber: 10,
);''',
          language: 'dart',
        ),
        const Gap(16),
        buildNote(null, 'verse_audio_control_note'.tr),
      ],
    );
  }
}
