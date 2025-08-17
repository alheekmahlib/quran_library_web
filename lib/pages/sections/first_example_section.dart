import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../widgets/code_block.dart';
import 'base_section_page.dart';

class FirstExampleSection extends BaseSectionPage {
  const FirstExampleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle('first_example'),
        const Gap(16),
        buildParagraph('first_example_description'),
        const Gap(16),
        CodeBlock(
          language: 'dart',
          code: '''/// You can just add it to your code like this:
/// يمكنك فقط إضافته إلى الكود الخاص بك هكذا:
class MyQuranPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return QuranLibraryScreen(
      parentContext: context, // مطلوب - Required
    );
  }
}''',
        ),
        const Gap(16),
        buildNote(null, 'example_note'),
      ],
    );
  }
}
