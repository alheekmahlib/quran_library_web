import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../core/content/content_models.dart';
import '../core/content/content_repository.dart';
import 'language_controller.dart';

class ContentController extends GetxController {
  static ContentController get instance => Get.find();

  final Rxn<SiteContent> _content = Rxn<SiteContent>();
  SiteContent? get content => _content.value;

  String get currentLang => LanguageController.instance.currentLanguage.value;
  String get defaultLang => content?.defaultLanguage ?? 'ar';
  String? latestVersion;

  // جلب آخر إصدار من pub.dev عبر CORS proxy
  Future<String> getLatestQuranLibraryVersion() async {
    try {
      // استخدام CORS proxy لتجاوز قيود المتصفح
      final response = await http
          .get(
            Uri.parse(
                'https://api.allorigins.win/raw?url=${Uri.encodeComponent('https://pub.dev/api/packages/quran_library')}'),
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final version = data['latest']['version'];
        latestVersion = '$version'; // إضافة ^ للتوافق مع pubspec
        log('Latest quran_library version: $latestVersion');
        return latestVersion!;
      }
    } catch (e) {
      log('Error fetching version: $e');
    }
    // في حالة الفشل، استخدم النسخة الاحتياطية
    latestVersion = '2.2.5';
    return latestVersion!;
  }

  Future<void> load() async {
    final data = await ContentRepository.instance.loadContent();
    _content.value = data;
    _padMissingTranslations();
    _validateTranslations();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    // Load content at startup
    await load();
    await getLatestQuranLibraryVersion();
  }

  SectionModel? getSection(String id) {
    final c = content;
    if (c == null) return null;
    return c.sectionsById[id];
  }

  void _validateTranslations() {
    final c = content;
    if (c == null) return;
    final langs = c.languages.isEmpty ? [defaultLang] : c.languages;

    List<String> issues = [];
    bool checkLocalized(String path, LocalizedText lt) {
      bool ok = true;
      for (final l in langs) {
        final v = lt.map[l] ?? '';
        if (v.isEmpty) {
          issues.add('Missing translation [$l] at $path');
          ok = false;
        }
      }
      return ok;
    }

    // Check groups titles
    for (final g in c.groups) {
      checkLocalized('group:${g.id}.title', g.title);
    }

    // Check sections titles and blocks
    for (final s in c.sectionsById.values) {
      checkLocalized('section:${s.id}.title', s.title);
      for (var i = 0; i < s.blocks.length; i++) {
        final b = s.blocks[i];
        checkLocalized('section:${s.id}.blocks[$i].content', b.content);
        // If block has items (list/feature_list), validate each item if localized
        final items = b.props['items'];
        if (items is List) {
          for (var j = 0; j < items.length; j++) {
            final it = items[j];
            if (it is Map<String, dynamic>) {
              checkLocalized(
                  'section:${s.id}.blocks[$i].items[$j]',
                  LocalizedText(
                      it.map((k, v) => MapEntry(k, v?.toString() ?? ''))));
            }
          }
        }
      }
    }

    if (issues.isNotEmpty) {
      // Print once to console; في الإنتاج يمكن تجاهل
      // استخدم debugPrint لمنع ازدحام السجلات
      for (final msg in issues) {
        // ignore: avoid_print
        print('[ContentValidator] $msg');
      }
    }
  }

  void _padMissingTranslations() {
    final c = content;
    if (c == null) return;
    final langs = c.languages.isEmpty ? [defaultLang] : c.languages;

    String fallbackValue(LocalizedText lt) {
      final def = lt.map[defaultLang];
      if (def != null && def.isNotEmpty) return def;
      // else take any non-empty
      return lt.map.values.firstWhere((v) => v.isNotEmpty, orElse: () => '');
    }

    void ensureAll(LocalizedText lt) {
      final fb = fallbackValue(lt);
      for (final l in langs) {
        if (!lt.map.containsKey(l) || (lt.map[l]?.isEmpty ?? true)) {
          lt.map[l] = fb;
        }
      }
    }

    for (final g in c.groups) {
      ensureAll(g.title);
    }

    for (final s in c.sectionsById.values) {
      ensureAll(s.title);
      for (final b in s.blocks) {
        ensureAll(b.content);
        final items = b.props['items'];
        if (items is List) {
          for (var i = 0; i < items.length; i++) {
            final it = items[i];
            if (it is Map<String, dynamic>) {
              final lt = LocalizedText(
                  it.map((k, v) => MapEntry(k, v?.toString() ?? '')));
              ensureAll(lt);
              // write back
              items[i] = lt.map;
            }
          }
        }
      }
    }
  }
}
