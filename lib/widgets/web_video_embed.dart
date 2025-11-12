// Minimal video embed for Flutter Web without extra dependencies.
// - YouTube/Vimeo: uses <iframe>
// - Direct MP4: uses <video controls>
// On non-web, renders a simple placeholder.

// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html; // for iframe/video elements
// نستخدم واجهة platformViewRegistry من dart:ui في وضع الويب للتسجيل
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class WebVideoEmbed extends StatelessWidget {
  final String url;
  final double aspectRatio; // e.g., 16/9 = 1.777...
  final BorderRadius borderRadius;

  const WebVideoEmbed({
    super.key,
    required this.url,
    this.aspectRatio = 16 / 9,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  });

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return _placeholder('الفيديو مدعوم على الويب فقط');
    }
    final lower = url.toLowerCase();
    final isYoutube =
        lower.contains('youtube.com') || lower.contains('youtu.be');
    final isVimeo = lower.contains('vimeo.com');
    final isMp4 = lower.endsWith('.mp4');

    if (!(isYoutube || isVimeo || isMp4)) {
      return _placeholder('رابط فيديو غير مدعوم حاليًا');
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: _HtmlVideo(url: url),
      ),
    );
  }

  Widget _placeholder(String msg) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Container(
          color: Colors.black,
          alignment: Alignment.center,
          child: Text(
            msg,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

// A separate widget to isolate web-only imports
class _HtmlVideo extends StatelessWidget {
  final String url;
  const _HtmlVideo({required this.url});

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) return const SizedBox.shrink();

    // Defer HTML element creation to a platform view
    return HtmlElementView(viewType: _registerViewFactory(url));
  }
}

String _registerViewFactory(String url) {
  final viewType =
      'web-video-${url.hashCode}-${DateTime.now().microsecondsSinceEpoch}';

  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
    final lower = url.toLowerCase();
    final isYoutube =
        lower.contains('youtube.com') || lower.contains('youtu.be');
    final isVimeo = lower.contains('vimeo.com');
    final isMp4 = lower.endsWith('.mp4');

    if (isYoutube) {
      final videoId = _extractYouTubeId(lower);
      final embedUrl = 'https://www.youtube.com/embed/$videoId';
      final iframe = html.IFrameElement()
        ..src = embedUrl
        ..style.border = '0'
        ..allow =
            'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share'
        ..allowFullscreen = true;
      return iframe;
    }
    if (isVimeo) {
      final videoId = _extractVimeoId(lower);
      final embedUrl = 'https://player.vimeo.com/video/$videoId';
      final iframe = html.IFrameElement()
        ..src = embedUrl
        ..style.border = '0'
        ..allow = 'autoplay; fullscreen; picture-in-picture'
        ..allowFullscreen = true;
      return iframe;
    }
    if (isMp4) {
      final video = html.VideoElement()
        ..src = url
        ..controls = true
        ..style.width = '100%'
        ..style.height = '100%';
      return video;
    }

    final fallback = html.DivElement()
      ..style.backgroundColor = 'black'
      ..style.color = 'white'
      ..style.display = 'flex'
      ..style.alignItems = 'center'
      ..style.justifyContent = 'center'
      ..text = 'Unsupported video URL';
    return fallback;
  });

  return viewType;
}

String _extractYouTubeId(String url) {
  // Handles youtu.be/ID and youtube.com/watch?v=ID
  final uri = Uri.tryParse(url);
  if (uri == null) return url;
  if (uri.host.contains('youtu.be')) {
    return uri.pathSegments.isNotEmpty ? uri.pathSegments.first : url;
  }
  if (uri.host.contains('youtube.com')) {
    final v = uri.queryParameters['v'];
    if (v != null && v.isNotEmpty) return v;
    // Also handle /embed/ID
    final idx = uri.pathSegments.indexOf('embed');
    if (idx != -1 && idx + 1 < uri.pathSegments.length) {
      return uri.pathSegments[idx + 1];
    }
  }
  return url;
}

String _extractVimeoId(String url) {
  final uri = Uri.tryParse(url);
  if (uri == null) return url;
  // Vimeo URLs: vimeo.com/ID or /channels/.../ID
  for (final seg in uri.pathSegments.reversed) {
    if (RegExp(r'^\d+$').hasMatch(seg)) return seg;
  }
  return url;
}
