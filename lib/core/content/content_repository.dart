import 'dart:async';

import 'package:flutter/services.dart' show rootBundle;

import '../../constants/app_constants.dart';
import 'content_models.dart';
import 'platform/content_platform_stub.dart'
    if (dart.library.html) 'platform/content_platform_web.dart';

class ContentRepository {
  ContentRepository._();
  static final ContentRepository instance = ContentRepository._();

  static const _localStorageKey = 'site_content_json_v1';
  SiteContent? _cache;

  Future<SiteContent?> loadContent() async {
    if (_cache != null) return _cache;

    final remoteUrl = AppConstants.contentJsonUrl.trim();

    // 1) Try remote
    if (remoteUrl.isNotEmpty) {
      try {
        final remoteJson = await _fetchRemote(remoteUrl);
        final parsed = SiteContent.tryParse(remoteJson);
        if (parsed != null) {
          _cache = parsed;
          _saveToLocal(remoteJson);
          return _cache;
        }
      } catch (_) {
        // ignore
      }
    }

    // 2) Try localStorage (web only)
    try {
      final cached = _loadFromLocal();
      if (cached != null) {
        final parsed = SiteContent.tryParse(cached);
        if (parsed != null) {
          _cache = parsed;
          return _cache;
        }
      }
    } catch (_) {}

    // 3) Try asset
    try {
      final asset = await rootBundle.loadString('assets/content/content.json');
      final parsed = SiteContent.tryParse(asset);
      if (parsed != null) {
        _cache = parsed;
        return _cache;
      }
    } catch (_) {}

    return null;
  }

  Future<bool> saveLocalAndApply(String jsonString) async {
    final parsed = SiteContent.tryParse(jsonString);
    if (parsed == null) return false;
    _cache = parsed;
    _saveToLocal(jsonString);
    return true;
  }

  Future<String> _fetchRemote(String url) => ContentPlatform().httpGet(url);

  void _saveToLocal(String jsonString) =>
      ContentPlatform().saveLocal(_localStorageKey, jsonString);

  String? _loadFromLocal() => ContentPlatform().loadLocal(_localStorageKey);
}
