import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../config/app_router.dart';
import 'language_controller.dart';

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();

  @override
  void onInit() {
    super.onInit();
    // Update navigation controller based on current route
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.context != null) {
        try {
          final state = GoRouterState.of(Get.context!);
          final sectionId = state.pathParameters['sectionId'];
          if (sectionId != null && sectionId.isNotEmpty) {
            updateSectionFromUrl(sectionId);
          }
        } catch (e) {
          // إذا لم نكن في مسار section، ابقَ على القسم الافتراضي
        }
      }
    });
  }

  // Observable for current section
  var currentSection = 'about-library'.obs;
  bool _isUpdatingFromUrl = false;

  void navigateToSection(String sectionKey, [BuildContext? context]) {
    if (_isUpdatingFromUrl) return;

    currentSection.value = sectionKey;

    // Try to get context from parameter or Get.context
    final buildContext = context ?? Get.context;
    if (buildContext != null) {
      final languageCode = LanguageController.instance.currentLanguage.value;
      final route = AppRouter.buildSectionRoute(languageCode, sectionKey);
      buildContext.go(route);
    }
  }

  // This method is called when the URL changes (path parameter format)
  void updateSectionFromUrl(String sectionPath) {
    _isUpdatingFromUrl = true;
    final sectionId = AppRouter.pathToSectionId(sectionPath);
    if (currentSection.value != sectionId) {
      currentSection.value = sectionId;
    }
    _isUpdatingFromUrl = false;
  }

  // Get current route path
  String get currentRoute {
    final languageCode = LanguageController.instance.currentLanguage.value;
    return AppRouter.buildSectionRoute(languageCode, currentSection.value);
  }
}
