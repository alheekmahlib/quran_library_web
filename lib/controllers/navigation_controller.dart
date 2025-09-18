import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../config/app_router.dart';

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();

  @override
  void onInit() {
    super.onInit();
    // Update navigation controller based on current route
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.context != null) {
        final currentRoute = GoRouterState.of(Get.context!).uri.toString();
        updateSectionFromUrl(currentRoute);
      }
    });
  }

  // Observable for current section
  var currentSection = 'what_is_quran_library'.obs;
  bool _isUpdatingFromUrl = false;

  void navigateToSection(String sectionKey, [BuildContext? context]) {
    if (_isUpdatingFromUrl) return;

    currentSection.value = sectionKey;

    // Try to get context from parameter or Get.context
    final buildContext = context ?? Get.context;
    if (buildContext != null) {
      final route = AppRouter.getRouteFromSection(sectionKey);
      buildContext.go(route);
    }
  }

  // This method is called when the URL changes
  void updateSectionFromUrl(String route) {
    _isUpdatingFromUrl = true;
    final section = AppRouter.getSectionFromRoute(route);
    if (currentSection.value != section) {
      currentSection.value = section;
    }
    _isUpdatingFromUrl = false;
  }

  // Get current route path
  String get currentRoute =>
      AppRouter.getRouteFromSection(currentSection.value);
}
