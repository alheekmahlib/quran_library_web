import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_theme.dart';
import '../controllers/content_controller.dart';
import '../controllers/language_controller.dart';

class _NavData {
  final Map<String, List<String>> groups; // title -> section ids
  final Map<String, String> labels; // section id -> resolved title
  _NavData(this.groups, this.labels);
}

class SideNavigationBar extends StatefulWidget {
  final Function(String) onItemSelected;
  final String selectedItem;

  const SideNavigationBar({
    super.key,
    required this.onItemSelected,
    required this.selectedItem,
  });

  @override
  State<SideNavigationBar> createState() => _SideNavigationBarState();
}

class _SideNavigationBarState extends State<SideNavigationBar> {
  _NavData _buildNavData() {
    final contentCtrl = Get.find<ContentController>();
    final lang = Get.find<LanguageController>().currentLanguage.value;
    final fallback = contentCtrl.content?.defaultLanguage ?? 'ar';

    final content = contentCtrl.content;
    // if (content == null || content.groups.isEmpty) {
    // Fallback to static structure using translations
    //   return _NavData({
    //     'getting_started'.tr: [
    //       'what_is_quran_library',
    //       'motivation_behind_library',
    //       'installation',
    //       'initial_setup',
    //     ],
    //     'usage_examples'.tr: [
    //       'first_example',
    //       'basic_quran_screen',
    //       'individual_surah_display',
    //     ],
    //     'utils'.tr: [
    //       'utility_functions',
    //       'navigation_jumping',
    //       'bookmarks',
    //       'quran_search',
    //     ],
    //     'fonts_download'.tr: [
    //       'download_quran_fonts',
    //     ],
    //     'tafsir'.tr: [
    //       'tafsir_initialization',
    //     ],
    //     'audio_playback'.tr: [
    //       'audio_verse_playback',
    //       'audio_surah_playback',
    //       'audio_download_management',
    //       'audio_position_control',
    //     ],
    //   }, const {});
    // }

    final groupsMap = <String, List<String>>{};
    final labels = <String, String>{};
    for (final g in content!.groups) {
      final title = g.title.resolve(lang, fallbackLang: fallback);
      final ids = <String>[];
      for (final sid in g.sectionIds) {
        final s = content.sectionsById[sid];
        if (s != null) {
          ids.add(s.id);
          labels[s.id] = s.title.resolve(lang, fallbackLang: fallback);
        }
      }
      if (ids.isNotEmpty) {
        groupsMap[title] = ids;
      }
    }
    return _NavData(groupsMap, labels);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      color: AppTheme.surfaceColor,
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'documentation'.tr,
                  style: GoogleFonts.cairo(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const Gap(8),
                Text(
                  'comprehensive_guide'.tr,
                  style: GoogleFonts.cairo(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: AppTheme.cardColor, height: 1),
          // Navigation sections
          Expanded(
            child: Obx(() {
              // Depend on language and content to rebuild
              final _ = Get.find<LanguageController>().currentLanguage.value;
              final __ = Get.find<ContentController>().content; // trigger
              final data = _buildNavData();
              return ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: data.groups.entries.map((section) {
                  return _buildSection(section.key, section.value, data.labels);
                }).toList(),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
      String title, List<String> items, Map<String, String> labels) {
    return ExpansionTile(
      title: Text(
        title,
        style: GoogleFonts.cairo(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppTheme.textPrimary,
        ),
      ),
      iconColor: AppTheme.primaryBlue,
      collapsedIconColor: AppTheme.textSecondary,
      initiallyExpanded: items.contains(widget.selectedItem),
      children: items.map((item) {
        final isSelected = widget.selectedItem == item;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: ListTile(
            title: Text(
              labels[item] ??
                  item.tr, // Prefer JSON label; fallback to translation key
              style: GoogleFonts.cairo(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color:
                    isSelected ? AppTheme.primaryBlue : AppTheme.textSecondary,
              ),
            ),
            selected: isSelected,
            selectedTileColor: AppTheme.primaryBlue.withValues(alpha: 0.1),
            onTap: () => widget.onItemSelected(item),
            dense: true,
            contentPadding: const EdgeInsets.only(right: 16),
          ),
        );
      }).toList(),
    );
  }
}
