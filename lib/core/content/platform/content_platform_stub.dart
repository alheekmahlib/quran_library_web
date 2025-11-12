class ContentPlatform {
  Future<String> httpGet(String url) async {
    throw UnsupportedError(
        'Remote fetch is only supported on web in this app.');
  }

  void saveLocal(String key, String jsonString) {
    // No-op on non-web
  }

  String? loadLocal(String key) {
    // No-op on non-web
    return null;
  }

  Future<String?> pickJsonFile() async {
    throw UnsupportedError('File picking is only supported on web.');
  }

  void downloadJson(String filename, String content) {
    // No-op on non-web
  }
}
