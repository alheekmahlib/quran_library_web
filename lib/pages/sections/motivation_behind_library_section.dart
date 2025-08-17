import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'base_section_page.dart';

class MotivationBehindLibrarySection extends BaseSectionPage {
  const MotivationBehindLibrarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle('motivation_behind_library'),
        const Gap(16),
        buildParagraph('motivation_description'),
        const Gap(16),
        buildSubtitle('key_benefits'),
        const Gap(12),
        buildFeaturesList([
          'benefit_performance',
          'benefit_arabic_optimization',
          'benefit_comprehensive_features',
          'benefit_audio_support',
          'benefit_offline_capability',
        ], 'key_benefits'),
        const Gap(24),
        buildNote('motivation_note'),
      ],
    );
  }
}
