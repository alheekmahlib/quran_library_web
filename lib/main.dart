import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'config/app_router.dart';
import 'constants/app_theme.dart';
import 'controllers/language_controller.dart';
import 'controllers/navigation_controller.dart';
import 'controllers/search_controller.dart';
import 'translations/app_translations.dart';

void main() {
  usePathUrlStrategy();
  // setUrlStrategy(PathUrlStrategy());
  runApp(const QuranLibraryWebsite());
}

class QuranLibraryWebsite extends StatelessWidget {
  const QuranLibraryWebsite({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      title: 'Quran Library - مكتبة القرآن',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: const Locale('ar'), // Default locale
      fallbackLocale: const Locale('en'),
      initialBinding: BindingsBuilder(() {
        Get.put(LanguageController());
        Get.put(NavigationController());
        Get.put(AppSearchController());
      }),
      routeInformationParser: AppRouter.router.routeInformationParser,
      routerDelegate: AppRouter.router.routerDelegate,
      routeInformationProvider: AppRouter.router.routeInformationProvider,
      builder: (context, child) {
        return ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        );
      },
    );
  }
}
