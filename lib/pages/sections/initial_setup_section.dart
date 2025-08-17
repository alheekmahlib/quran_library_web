import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../widgets/code_block.dart';
import 'base_section_page.dart';

class InitialSetupSection extends BaseSectionPage {
  const InitialSetupSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle('initial_setup'.tr),
        buildSubtitle('Initialization'),
        const Gap(24),
        buildParagraph('initialization_instruction'.tr),
        const Gap(16),
        const CodeBlock(
          code: '''void main() {
  runApp(MyApp());
    // تهيئة مكتبة القرآن
    QuranLibrary.init();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'تطبيق القرآن',
      theme: ThemeData(
        useMaterial3: false, // مهم جداً!
      ),
      home: MyHomePage(),
    );
  }
}''',
          language: 'dart',
        ),
      ],
    );
  }
}
