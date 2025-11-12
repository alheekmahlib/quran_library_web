import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controllers/language_controller.dart';
import '../pages/admin/admin_page.dart';
import '../pages/home_page.dart';

/// مسار ديناميكي بالكامل يدعم جميع الأقسام تلقائيًا
class AppRouter {
  static const String home = '/';

  static final GoRouter router = GoRouter(
    initialLocation: '/ar', // اللغة الافتراضية
    routes: [
      GoRoute(
        name: "home",
        path: '/:languageCode',
        pageBuilder: (context, state) {
          final languageCode = state.pathParameters['languageCode'] ?? 'ar';
          LanguageController.instance.updateLanguageFromUrl('/$languageCode');
          return CustomTransitionPage(
            key: state.pageKey,
            child: const HomePage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        },
        routes: <RouteBase>[
          // صفحة الإدارة
          GoRoute(
            name: "admin",
            path: "admin",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const AdminPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          // مسار ديناميكي لجميع الأقسام
          GoRoute(
            name: "section",
            path: "section/:sectionId",
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const HomePage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              );
            },
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final languageCode = state.pathParameters['languageCode'];
      if (languageCode == null || languageCode.isEmpty) {
        return '/ar/section/about-library';
      }
      // إذا كان المسار هو اللغة فقط بدون قسم، نوجه إلى about-library
      if (state.matchedLocation == '/$languageCode') {
        return '/$languageCode/section/about-library';
      }
      return null;
    },
  );

  /// بناء مسار كامل للقسم بناءً على اللغة و ID
  static String buildSectionRoute(String languageCode, String sectionId) {
    return '/$languageCode/section/${sectionIdToPath(sectionId)}';
  }

  /// تحويل snake_case إلى kebab-case للروابط
  static String sectionIdToPath(String sectionId) {
    return sectionId.replaceAll('_', '-');
  }

  /// تحويل kebab-case إلى snake_case
  static String pathToSectionId(String path) {
    return path.replaceAll('-', '_');
  }
}
