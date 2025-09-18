import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  static LanguageController get instance => Get.find();

  // Observable for current language
  RxString currentLanguage = 'ar'.obs;
  RxBool isDropdownOpen = false.obs;

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

    // تأجيل تحديث اللغة إلى ما بعد اكتمال عملية البناء
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Locale locale = Locale(languageCode);
      Get.updateLocale(locale);
    });
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

  void updateLanguageFromUrl(String url) {
    try {
      final uri = Uri.parse(url);
      final languageCode =
          uri.pathSegments.isNotEmpty ? uri.pathSegments.first : 'ar';
      if (languages.any((lang) => lang.code == languageCode)) {
        changeLanguage(languageCode);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error parsing URL for language: $e');
      }
    }
  }
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
