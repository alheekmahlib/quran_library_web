import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/home_page.dart';

class AppRouter {
  static const String home = '/';
  static const String introduction = '/introduction';
  static const String whatIsQuranLibrary = '/what-is-quran-library';
  static const String motivationBehindLibrary = '/motivation-behind-library';
  static const String quickStart = '/quick-start';
  static const String installation = '/installation';
  static const String initialSetup = '/initial-setup';
  static const String firstExample = '/first-example';
  static const String basicUsage = '/basic-usage';
  static const String basicQuranScreen = '/basic-quran-screen';
  static const String individualSurahDisplay = '/individual-surah-display';
  static const String optionsCustomization = '/options-customization';
  static const String advancedFeatures = '/advanced-features';
  static const String searchFunctionality = '/search-functionality';
  static const String bookmarks = '/bookmarks';
  static const String tafsirIntegration = '/tafsir-integration';
  static const String customThemes = '/custom-themes';
  static const String customization = '/customization';
  static const String theming = '/theming';
  static const String fontsTypography = '/fonts-typography';
  static const String colorsAppearance = '/colors-appearance';
  static const String apiReference = '/api-reference';
  static const String coreClasses = '/core-classes';
  static const String widgetCatalog = '/widget-catalog';
  static const String configurationOptions = '/configuration-options';

  // New sections
  static const String utilityFunctions = '/utility-functions';
  static const String navigationJumping = '/navigation-jumping';
  static const String quranSearch = '/quran-search';
  static const String downloadQuranFonts = '/download-quran-fonts';
  static const String tafsirInitialization = '/tafsir-initialization';
  static const String audioVersePlayback = '/audio-verse-playback';
  static const String audioSurahPlayback = '/audio-surah-playback';
  static const String audioDownloadManagement = '/audio-download-management';
  static const String audioPositionControl = '/audio-position-control';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        name: "home",
        path: home,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
        routes: <RouteBase>[
          GoRoute(
            name: "introduction",
            path: "introduction",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "what_is_quran_library",
            path: "what-is-quran-library",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "motivation_behind_library",
            path: "motivation-behind-library",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "quick_start",
            path: "quick-start",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "installation",
            path: "installation",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "initial_setup",
            path: "initial-setup",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "first_example",
            path: "first-example",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "basic_usage",
            path: "basic-usage",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "basic_quran_screen",
            path: "basic-quran-screen",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "individual_surah_display",
            path: "individual-surah-display",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "options_customization",
            path: "options-customization",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "advanced_features",
            path: "advanced-features",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "search_functionality",
            path: "search-functionality",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "bookmarks",
            path: "bookmarks",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "tafsir_integration",
            path: "tafsir-integration",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "custom_themes",
            path: "custom-themes",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "customization",
            path: "customization",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "theming",
            path: "theming",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "fonts_typography",
            path: "fonts-typography",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "colors_appearance",
            path: "colors-appearance",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "api_reference",
            path: "api-reference",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "core_classes",
            path: "core-classes",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "widget_catalog",
            path: "widget-catalog",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "configuration_options",
            path: "configuration-options",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "utility_functions",
            path: "utility-functions",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "navigation_jumping",
            path: "navigation-jumping",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "quran_search",
            path: "quran-search",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "download_quran_fonts",
            path: "download-quran-fonts",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "tafsir_initialization",
            path: "tafsir-initialization",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "audio_verse_playback",
            path: "audio-verse-playback",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "audio_surah_playback",
            path: "audio-surah-playback",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "audio_download_management",
            path: "audio-download-management",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
          GoRoute(
            name: "audio_position_control",
            path: "audio-position-control",
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          ),
        ],
      ),
    ],
  );

  // Helper function to get route name from section key
  static String getRouteFromSection(String sectionKey) {
    switch (sectionKey) {
      case 'introduction':
        return '/introduction';
      case 'what_is_quran_library':
        return '/what-is-quran-library';
      case 'motivation_behind_library':
        return '/motivation-behind-library';
      case 'quick_start':
        return '/quick-start';
      case 'installation':
        return '/installation';
      case 'initial_setup':
        return '/initial-setup';
      case 'first_example':
        return '/first-example';
      case 'basic_usage':
        return '/basic-usage';
      case 'basic_quran_screen':
        return '/basic-quran-screen';
      case 'individual_surah_display':
        return '/individual-surah-display';
      case 'options_customization':
        return '/options-customization';
      case 'advanced_features':
        return '/advanced-features';
      case 'search_functionality':
        return '/search-functionality';
      case 'bookmarks':
        return '/bookmarks';
      case 'tafsir_integration':
        return '/tafsir-integration';
      case 'custom_themes':
        return '/custom-themes';
      case 'customization':
        return '/customization';
      case 'theming':
        return '/theming';
      case 'fonts_typography':
        return '/fonts-typography';
      case 'colors_appearance':
        return '/colors-appearance';
      case 'api_reference':
        return '/api-reference';
      case 'core_classes':
        return '/core-classes';
      case 'widget_catalog':
        return '/widget-catalog';
      case 'configuration_options':
        return '/configuration-options';
      case 'utility_functions':
        return '/utility-functions';
      case 'navigation_jumping':
        return '/navigation-jumping';
      case 'quran_search':
        return '/quran-search';
      case 'download_quran_fonts':
        return '/download-quran-fonts';
      case 'tafsir_initialization':
        return '/tafsir-initialization';
      case 'audio_verse_playback':
        return '/audio-verse-playback';
      case 'audio_surah_playback':
        return '/audio-surah-playback';
      case 'audio_download_management':
        return '/audio-download-management';
      case 'audio_position_control':
        return '/audio-position-control';
      default:
        return home;
    }
  }

  // Helper function to get section key from route
  static String getSectionFromRoute(String route) {
    switch (route) {
      case '/introduction':
        return 'introduction';
      case '/what-is-quran-library':
        return 'what_is_quran_library';
      case '/motivation-behind-library':
        return 'motivation_behind_library';
      case '/quick-start':
        return 'quick_start';
      case '/installation':
        return 'installation';
      case '/initial-setup':
        return 'initial_setup';
      case '/first-example':
        return 'first_example';
      case '/basic-usage':
        return 'basic_usage';
      case '/basic-quran-screen':
        return 'basic_quran_screen';
      case '/individual-surah-display':
        return 'individual_surah_display';
      case '/options-customization':
        return 'options_customization';
      case '/advanced-features':
        return 'advanced_features';
      case '/search-functionality':
        return 'search_functionality';
      case '/bookmarks':
        return 'bookmarks';
      case '/tafsir-integration':
        return 'tafsir_integration';
      case '/custom-themes':
        return 'custom_themes';
      case '/customization':
        return 'customization';
      case '/theming':
        return 'theming';
      case '/fonts-typography':
        return 'fonts_typography';
      case '/colors-appearance':
        return 'colors_appearance';
      case '/api-reference':
        return 'api_reference';
      case '/core-classes':
        return 'core_classes';
      case '/widget-catalog':
        return 'widget_catalog';
      case '/configuration-options':
        return 'configuration_options';
      case '/utility-functions':
        return 'utility_functions';
      case '/navigation-jumping':
        return 'navigation_jumping';
      case '/quran-search':
        return 'quran_search';
      case '/download-quran-fonts':
        return 'download_quran_fonts';
      case '/tafsir-initialization':
        return 'tafsir_initialization';
      case '/audio-verse-playback':
        return 'audio_verse_playback';
      case '/audio-surah-playback':
        return 'audio_surah_playback';
      case '/audio-download-management':
        return 'audio_download_management';
      case '/audio-position-control':
        return 'audio_position_control';
      case '/':
      default:
        return 'what_is_quran_library';
    }
  }
}
