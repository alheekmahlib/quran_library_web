import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_theme.dart';
import '../controllers/navigation_controller.dart';
import '../pages/content_page.dart';
import '../widgets/side_navigation_bar.dart';
import '../widgets/top_navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: const TopNavigationBar(),
      endDrawer: MediaQuery.of(context).size.width > 800
          ? null
          : _buildMobileDrawer(context),
      body: MediaQuery.of(context).size.width < 800
          ? _buildMobileLayout()
          : _buildDesktopLayout(context),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    final navController = Get.find<NavigationController>();

    return Row(
      children: [
        // Side navigation
        Obx(() => SideNavigationBar(
              onItemSelected: (item) {
                navController.navigateToSection(item, context);
              },
              selectedItem: navController.currentSection.value,
            )),
        // Vertical divider
        Container(
          width: 1,
          color: AppTheme.cardColor,
        ),
        // Main content with LayoutBuilder to ensure proper layout
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SelectionArea(
                child: ContentPage(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SelectionArea(
          child: ContentPage(),
        );
      },
    );
  }

  Widget _buildMobileDrawer(BuildContext context) {
    final navController = Get.find<NavigationController>();

    return Drawer(
      backgroundColor: AppTheme.surfaceColor,
      child: Obx(() => SideNavigationBar(
            onItemSelected: (item) {
              navController.navigateToSection(item, context);
              Navigator.of(context).pop(); // Close drawer
            },
            selectedItem: navController.currentSection.value,
          )),
    );
  }
}
