import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../widgets/code_block.dart';
import 'base_section_page.dart';

class InstallationSection extends BaseSectionPage {
  const InstallationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle('installation'.tr),
        buildSubtitle('Installation'),
        const Gap(24),
        buildParagraph('installation_instruction'.tr),
        const Gap(16),
        const CodeBlock(
          code: '''dependencies:
  ...
  quran_library: ^2.0.0''',
          language: 'yaml',
        ),
        const Gap(24),
        buildParagraph('run_command'.tr),
        const Gap(16),
        const CodeBlock(
          code: 'flutter pub get',
          language: 'bash',
        ),
        const Gap(24),
        buildParagraph('import_instruction'.tr),
        const Gap(16),
        const CodeBlock(
          code: "import 'package:quran_library/quran_library.dart';",
          language: 'dart',
        ),
        const Gap(32),
        buildSubtitle('permissions'.tr),
        const Gap(16),
        buildSubtitle('android_permissions'.tr),
        const Gap(12),
        buildParagraph('android_permissions_description'.tr),
        const Gap(16),
        buildSubtitle('ios_permissions'.tr),
        const Gap(12),
        buildParagraph('ios_permissions_description'.tr),
        const Gap(16),
        const CodeBlock(
          code: '''<key>UIBackgroundModes</key>
<array>
  <string>audio</string>
</array>''',
          language: 'xml',
        ),
        const Gap(16),
        buildParagraph('ios_permissions_note'.tr),
        const Gap(24),
        buildSubtitle('initialize_library'.tr),
        const Gap(16),
        const CodeBlock(
          code: 'QuranLibrary.init();',
          language: 'dart',
        ),
      ],
    );
  }
}
