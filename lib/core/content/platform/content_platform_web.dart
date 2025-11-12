import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class ContentPlatform {
  Future<String> httpGet(String url) async {
    final req = await html.HttpRequest.request(url, method: 'GET');
    final text = req.responseText ?? '';
    if (text.isEmpty) {
      throw Exception('Empty response');
    }
    return text;
  }

  void saveLocal(String key, String jsonString) {
    try {
      html.window.localStorage[key] = jsonString;
    } catch (_) {
      // ignore
    }
  }

  String? loadLocal(String key) {
    try {
      return html.window.localStorage[key];
    } catch (_) {
      return null;
    }
  }

  Future<String?> pickJsonFile() async {
    final input = html.FileUploadInputElement()
      ..accept = '.json,application/json';
    final completer = Completer<String?>();
    input.onChange.listen((event) {
      final files = input.files;
      if (files == null || files.isEmpty) {
        completer.complete(null);
        return;
      }
      final file = files.first;
      final reader = html.FileReader();
      reader.onLoadEnd.listen((_) {
        completer.complete(reader.result?.toString());
      });
      reader.readAsText(file);
    });
    input.click();
    return completer.future;
  }

  void downloadJson(String filename, String content) {
    final bytes = html.Blob([content], 'application/json');
    final url = html.Url.createObjectUrlFromBlob(bytes);
    html.AnchorElement(href: url)
      ..setAttribute('download', filename)
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}
