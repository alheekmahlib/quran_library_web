import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  static LanguageController get instance => Get.find();

  // Observable for current language
  var currentLanguage = 'ar'.obs;
  var isDropdownOpen = false.obs;

  // Available languages
  final List<LanguageModel> languages = [
    LanguageModel(
      name: 'العربية',
      code: 'ar',
      flag: '🇸🇦',
    ),
    LanguageModel(
      name: 'English',
      code: 'en',
      flag: '🇺🇸',
    ),
    LanguageModel(
      name: 'বাংলা',
      code: 'bn',
      flag: '🇧🇩',
    ),
    LanguageModel(
      name: 'Bahasa Indonesia',
      code: 'id',
      flag: '🇮🇩',
    ),
    LanguageModel(
      name: 'اردو',
      code: 'ur',
      flag: '🇵🇰',
    ),
    LanguageModel(
      name: 'Türkçe',
      code: 'tr',
      flag: '🇹🇷',
    ),
    LanguageModel(
      name: 'کوردی',
      code: 'ku',
      flag: '🔰',
    ),
    LanguageModel(
      name: 'Bahasa Malaysia',
      code: 'ms',
      flag: '🇲🇾',
    ),
    LanguageModel(
      name: 'Español',
      code: 'es',
      flag: '🇪🇸',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    // Set default language to Arabic
    changeLanguage('ar');
  }

  void changeLanguage(String languageCode) {
    currentLanguage.value = languageCode;

    // Update GetX locale
    Locale locale = Locale(languageCode);
    Get.updateLocale(locale);
  }

  void toggleDropdown() {
    isDropdownOpen.value = !isDropdownOpen.value;
  }

  void closeDropdown() {
    isDropdownOpen.value = false;
  }

  LanguageModel get currentLanguageModel {
    return languages.firstWhere(
      (lang) => lang.code == currentLanguage.value,
      orElse: () => languages.first,
    );
  }

  String getCurrentLanguageName() {
    return currentLanguageModel.name;
  }

  bool get isArabic => currentLanguage.value == 'ar';
  bool get isEnglish => currentLanguage.value == 'en';
}

class LanguageModel {
  final String name;
  final String code;
  final String flag;

  LanguageModel({
    required this.name,
    required this.code,
    required this.flag,
  });

  @override
  String toString() => name;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LanguageModel && other.code == code;
  }

  @override
  int get hashCode => code.hashCode;
}
