import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_theme.dart';
import '../../../controllers/admin_controller.dart';
import '../../sections/dynamic_section_page.dart';

class PreviewPanel extends StatelessWidget {
  const PreviewPanel({super.key});
  @override
  Widget build(BuildContext context) {
    final admin = AdminController.instance;
    return Obx(() {
      final section = admin.selectedSection;
      // Force rebuild when working content changes
      admin.working.value;

      if (section == null) {
        return const Center(child: Text('لا يوجد قسم محدد'));
      }
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.backgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.cardColor),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: DynamicSectionPage(section: section),
            ),
          ),
        ),
      );
    });
  }
}
