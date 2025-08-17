import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../widgets/code_block.dart';
import 'base_section_page.dart';

class QuranSearchSection extends BaseSectionPage {
  const QuranSearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle('utility_functions'),
        const Gap(24),
        buildSubtitle('quran_search'),
        const Gap(12),
        CodeBlock(
          language: 'dart',
          code: '''TextField(
  onChanged: (txt) {
    final _ayahs = QuranLibrary().search(txt);
      setState(() {
        ayahs = [..._ayahs];
      });
  },
  decoration: InputDecoration(
    border:  OutlineInputBorder(borderSide: BorderSide(color: Colors.black),),
    hintText: 'بحث',
  ),
),''',
        ),
      ],
    );
  }
}
