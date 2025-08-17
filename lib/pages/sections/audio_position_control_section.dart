import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../widgets/code_block.dart';
import 'base_section_page.dart';

class AudioPositionControlSection extends BaseSectionPage {
  const AudioPositionControlSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle('utility_functions'),
        const Gap(16),
        buildSubtitle('position_control_resume'),
        const Gap(16),
        const CodeBlock(
          code: '''/// الحصول على رقم السورة الحالية/الأخيرة
/// Get current/last surah number
int currentSurah = QuranLibrary().currentAndLastSurahNumber;

/// الحصول على الموضع الأخير كنص منسق (مثل "05:23")
/// Get last position as formatted text (like "05:23")
String lastTimeText = QuranLibrary().formatLastPositionToTime;

/// الحصول على الموضع الأخير كمدة زمنية للعمليات البرمجية
/// Get last position as Duration object for programming operations
Duration lastDuration = QuranLibrary().formatLastPositionToDuration;

/// تشغيل من الموضع الأخير الذي توقف عنده المستخدم
/// Play from the last position where user stopped
await QuranLibrary().playLastPosition();''',
          language: 'dart',
        ),
      ],
    );
  }
}
