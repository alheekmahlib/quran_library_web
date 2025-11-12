import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_theme.dart';
import '../controllers/content_controller.dart';
import '../controllers/navigation_controller.dart';
import 'sections/dynamic_section_page.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final navController = Get.find<NavigationController>();

    return Container(
      color: AppTheme.backgroundColor,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(
          MediaQuery.of(context).size.width > 800 ? 32 : 16,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Obx(() => _buildContent(navController.currentSection.value)),
        ),
      ),
    );
  }

  Widget _buildContent(String currentSection) {
    // Try dynamic content first
    final contentCtrl = Get.find<ContentController>();
    final dynamicSection = contentCtrl.getSection(currentSection);
    if (dynamicSection != null) {
      return DynamicSectionPage(section: dynamicSection);
    }

    // جميع الأقسام القديمة أزيلت لصالح المحتوى الديناميكي.
    return const Center(child: Text('القسم غير متوفر في المحتوى الديناميكي'));
  }
}
