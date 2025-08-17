import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'navigation_controller.dart';

class AppSearchController extends GetxController {
  static AppSearchController get to => Get.find();

  final TextEditingController textController = TextEditingController();
  final RxBool isSearching = false.obs;
  final RxList<SearchResult> searchResults = <SearchResult>[].obs;
  final RxString searchQuery = ''.obs;

  // Define all searchable content
  final List<SearchableItem> _searchableItems = [
    // Getting Started
    SearchableItem(
      title: 'What is Quran Library?',
      titleKey: 'what_is_quran_library',
      sectionKey: 'what_is_quran_library',
      keywords: ['what', 'quran', 'library', 'introduction', 'about'],
    ),
    SearchableItem(
      title: 'Motivation Behind Library',
      titleKey: 'motivation_behind_library',
      sectionKey: 'motivation_behind_library',
      keywords: ['motivation', 'why', 'purpose', 'goal'],
    ),
    SearchableItem(
      title: 'Installation',
      titleKey: 'installation',
      sectionKey: 'installation',
      keywords: ['install', 'setup', 'pubspec', 'dependency'],
    ),
    SearchableItem(
      title: 'Initial Setup',
      titleKey: 'initial_setup',
      sectionKey: 'initial_setup',
      keywords: ['initialization', 'setup', 'configure', 'init'],
    ),

    // Usage Examples
    SearchableItem(
      title: 'First Example',
      titleKey: 'first_example',
      sectionKey: 'first_example',
      keywords: ['example', 'first', 'basic', 'start'],
    ),
    SearchableItem(
      title: 'Basic Quran Screen',
      titleKey: 'basic_quran_screen',
      sectionKey: 'basic_quran_screen',
      keywords: ['screen', 'basic', 'display', 'ui'],
    ),
    SearchableItem(
      title: 'Individual Surah Display',
      titleKey: 'individual_surah_display',
      sectionKey: 'individual_surah_display',
      keywords: ['surah', 'individual', 'chapter', 'display'],
    ),

    // Utils
    SearchableItem(
      title: 'Utility Functions',
      titleKey: 'utility_functions',
      sectionKey: 'utility_functions',
      keywords: ['utilities', 'functions', 'helpers', 'tools'],
    ),
    SearchableItem(
      title: 'Navigation and Jumping',
      titleKey: 'navigation_jumping',
      sectionKey: 'navigation_jumping',
      keywords: ['navigation', 'jump', 'goto', 'move'],
    ),
    SearchableItem(
      title: 'Bookmarks',
      titleKey: 'bookmarks',
      sectionKey: 'bookmarks',
      keywords: ['bookmark', 'save', 'favorite', 'mark'],
    ),
    SearchableItem(
      title: 'Quran Search',
      titleKey: 'quran_search',
      sectionKey: 'quran_search',
      keywords: ['search', 'find', 'verse', 'text'],
    ),

    // Fonts Download
    SearchableItem(
      title: 'Download Quran Fonts',
      titleKey: 'download_quran_fonts',
      sectionKey: 'download_quran_fonts',
      keywords: ['fonts', 'download', 'typography', 'arabic'],
    ),

    // Tafsir
    SearchableItem(
      title: 'Tafsir Initialization',
      titleKey: 'tafsir_initialization',
      sectionKey: 'tafsir_initialization',
      keywords: ['tafsir', 'interpretation', 'explanation', 'commentary'],
    ),

    // Audio Playback
    SearchableItem(
      title: 'Verse Audio Playback',
      titleKey: 'audio_verse_playback',
      sectionKey: 'audio_verse_playback',
      keywords: ['audio', 'verse', 'play', 'sound', 'recitation'],
    ),
    SearchableItem(
      title: 'Surah Audio Playback',
      titleKey: 'audio_surah_playback',
      sectionKey: 'audio_surah_playback',
      keywords: ['audio', 'surah', 'chapter', 'play', 'recitation'],
    ),
    SearchableItem(
      title: 'Audio Download Management',
      titleKey: 'audio_download_management',
      sectionKey: 'audio_download_management',
      keywords: ['download', 'audio', 'management', 'offline'],
    ),
    SearchableItem(
      title: 'Audio Position Control',
      titleKey: 'audio_position_control',
      sectionKey: 'audio_position_control',
      keywords: ['position', 'control', 'resume', 'seek', 'audio'],
    ),
  ];

  void performSearch(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    final results = <SearchResult>[];
    final queryLower = query.toLowerCase();

    for (final item in _searchableItems) {
      final score = _calculateSearchScore(item, queryLower);
      if (score > 0) {
        results.add(SearchResult(
          item: item,
          score: score,
          matchedKeywords: _getMatchedKeywords(item, queryLower),
        ));
      }
    }

    // Sort by score (highest first)
    results.sort((a, b) => b.score.compareTo(a.score));
    searchResults.value = results.take(8).toList(); // Limit to 8 results
  }

  double _calculateSearchScore(SearchableItem item, String query) {
    double score = 0;

    // Check title match
    final titleKey = item.titleKey.tr.toLowerCase();
    if (titleKey.contains(query)) {
      score += titleKey == query ? 100 : 50; // Exact match gets higher score
    }

    // Check keywords match
    for (final keyword in item.keywords) {
      if (keyword.toLowerCase().contains(query)) {
        score += keyword.toLowerCase() == query ? 30 : 15;
      }
    }

    // Partial match bonus
    if (query.length >= 3) {
      for (final keyword in item.keywords) {
        if (keyword.toLowerCase().startsWith(query)) {
          score += 10;
        }
      }
    }

    return score;
  }

  List<String> _getMatchedKeywords(SearchableItem item, String query) {
    final matched = <String>[];
    for (final keyword in item.keywords) {
      if (keyword.toLowerCase().contains(query)) {
        matched.add(keyword);
      }
    }
    return matched;
  }

  void navigateToResult(SearchResult result, BuildContext context) {
    final navController = Get.find<NavigationController>();
    navController.navigateToSection(result.item.sectionKey, context);
    clearSearch();
  }

  void clearSearch() {
    textController.clear();
    searchQuery.value = '';
    searchResults.clear();
    isSearching.value = false;
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      clearSearch();
    } else {
      // Clear any existing search when opening
      searchResults.clear();
      searchQuery.value = '';
    }
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}

class SearchableItem {
  final String title;
  final String titleKey;
  final String sectionKey;
  final List<String> keywords;

  SearchableItem({
    required this.title,
    required this.titleKey,
    required this.sectionKey,
    required this.keywords,
  });
}

class SearchResult {
  final SearchableItem item;
  final double score;
  final List<String> matchedKeywords;

  SearchResult({
    required this.item,
    required this.score,
    required this.matchedKeywords,
  });
}
