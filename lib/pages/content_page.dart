import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_theme.dart';
import '../controllers/navigation_controller.dart';
import 'sections/audio_position_control_section.dart';
import 'sections/sections.dart';
import 'sections/surah_download_management_section.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final navController = Get.find<NavigationController>();

    return Container(
      color: AppTheme.backgroundColor,
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(
          MediaQuery.of(context).size.width > 800 ? 32 : 16,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width > 1200
                  ? 1000
                  : double.infinity,
            ),
            child: Obx(() => _buildContent(navController.currentSection.value)),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(String currentSection) {
    switch (currentSection) {
      case 'what_is_quran_library':
        return const WhatIsQuranLibrarySection();
      case 'installation':
        return const InstallationSection();
      case 'initial_setup':
        return const InitialSetupSection();
      case 'motivation_behind_library':
        return const MotivationBehindLibrarySection();
      case 'first_example':
        return const FirstExampleSection();
      case 'basic_quran_screen':
        return const BasicQuranScreenSection();
      case 'individual_surah_display':
        return const IndividualSurahDisplaySection();
      case 'audio_verse_playback':
        return const AudioVersePlaybackSection();
      case 'audio_surah_playback':
        return const AudioSurahPlaybackSection();
      case 'utility_functions':
        return const UtilityFunctionsSection();
      case 'navigation_jumping':
        return const NavigationJumpingSection();
      case 'quran_search':
        return const QuranSearchSection();
      case 'download_quran_fonts':
        return const DownloadQuranFontsSection();
      case 'bookmarks':
        return const BookmarkSection();
      case 'tafsir_initialization':
        return const TafsirSection();
      case 'audio_download_management':
        return const SurahDownloadManagementSection();
      case 'audio_position_control':
        return const AudioPositionControlSection();

      default:
        return const WhatIsQuranLibrarySection();
    }
  }

  Widget _buildPlaceholder(String sectionKey) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.construction,
            size: 64,
            color: AppTheme.primaryBlue,
          ),
          const SizedBox(height: 16),
          Text(
            'Section: ${sectionKey.tr}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'This section is being migrated to the new component structure.',
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
