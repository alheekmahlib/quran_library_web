// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html; // for opening video links on web

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_theme.dart';
import '../../controllers/content_controller.dart';
import '../../core/content/content_models.dart';
import '../../widgets/code_block.dart';

class DynamicSectionPage extends StatelessWidget {
  final SectionModel section;
  const DynamicSectionPage({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    final contentCtrl = ContentController.instance;
    final lang = contentCtrl.currentLang;
    final fallback = contentCtrl.defaultLang;
    final children = section.children;

    return SelectionArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          _buildTitle(section.title.resolve(lang, fallbackLang: fallback)),
          const Gap(24),
          // Blocks
          ...section.blocks.expand((b) => [
                Builder(
                  builder: (ctx) => _buildBlock(ctx, b, lang, fallback),
                ),
                const Gap(16),
              ]),
          if (children.isNotEmpty) ...[
            const Gap(24),
            _buildSubtitle('# أقسام فرعية'),
            const Gap(12),
            ...children.expand((cid) {
              final child = contentCtrl.content?.sectionsById[cid];
              if (child == null) return [const SizedBox.shrink()];
              return [
                _NestedSectionView(
                    section: child, depth: 1, visited: {section.id}),
                const Gap(24),
              ];
            }),
          ],
        ],
      ),
    );
  }

  Widget _buildBlock(
      BuildContext context, BlockModel block, String lang, String fallback) {
    switch (block.type) {
      case 'title':
        return _buildTitle(block.content.resolve(lang, fallbackLang: fallback));
      case 'subtitle':
        return _buildSubtitle(
            block.content.resolve(lang, fallbackLang: fallback));
      case 'subsection':
        return _buildSubsection(context, block, lang, fallback);
      case 'gap':
        return _buildGap(block);
      case 'paragraph':
        return _buildParagraph(
            block.content.resolve(lang, fallbackLang: fallback));
      case 'note':
        return _buildNote(block.content.resolve(lang, fallbackLang: fallback));
      case 'warning':
        return _buildWarning(
            block.content.resolve(lang, fallbackLang: fallback));
      case 'divider':
        return const Divider(color: AppTheme.cardColor, height: 32);
      case 'feature_list':
        return _buildFeaturesList(
          _resolveItems(block.props['items'], lang, fallback),
          block.content.resolve(lang, fallbackLang: fallback),
        );
      case 'list':
        return _buildBulletedList(
          _resolveItems(block.props['items'], lang, fallback),
          block.content.resolve(lang, fallbackLang: fallback),
        );
      case 'code':
        return CodeBlock(
          code: block.content.resolve(lang, fallbackLang: fallback),
          language: (block.props['language'] ?? 'dart').toString(),
        );
      case 'image':
        final imageUrls = (block.props['urls'] as List?)?.cast<String>() ??
            [(block.props['url'] ?? '').toString()];
        return _buildImages(
            context, imageUrls, block.props['width']?.toString());
      case 'video':
        return _buildVideo(
          block.props['url']?.toString() ?? '',
          (block.props['aspectRatio'] != null)
              ? double.tryParse(block.props['aspectRatio'].toString()) ?? 16 / 9
              : 16 / 9,
          block.props['width']?.toString(),
        );
      case 'custom':
        return _buildCustom(block.props['id']?.toString() ?? '');
      default:
        return _buildWarning('# Unknown block type: ${block.type}');
    }
  }

  Widget _buildGap(BlockModel block) {
    final raw = block.props['height']?.toString() ?? '16';
    final h = double.tryParse(raw) ?? 16.0;
    final height = h < 0 ? 0 : h; // لا ارتفاع سلبي
    return SizedBox(height: height.toDouble());
  }

  Widget _buildSubsection(
      BuildContext context, BlockModel block, String lang, String fallback) {
    final title = block.content.resolve(lang, fallbackLang: fallback);
    final rawChildren = (block.props['children'] as List?) ?? const [];
    final children = rawChildren
        .whereType<Map>()
        .map((e) => BlockModel.fromJson(e.cast<String, dynamic>()))
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty) _buildSubtitle(title),
        if (title.isNotEmpty) const Gap(8),
        ...children.expand((c) => [
              _buildBlock(context, c, lang, fallback),
              const Gap(12),
            ]),
      ],
    );
  }

  List<String> _resolveItems(dynamic items, String lang, String fallback) {
    if (items is List) {
      return items
          .map((e) => _resolveLocalizedString(e, lang, fallback))
          .where((e) => e.isNotEmpty)
          .toList();
    }
    return const [];
  }

  String _resolveLocalizedString(dynamic item, String lang, String fallback) {
    if (item is String) return item; // plain string
    if (item is Map<String, dynamic>) {
      final lt =
          LocalizedText(item.map((k, v) => MapEntry(k, v?.toString() ?? '')));
      return lt.resolve(lang, fallbackLang: fallback);
    }
    return '';
  }

  // Styling helpers (mirroring BaseSectionPage styles)
  Widget _buildTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.cairo(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: AppTheme.textPrimary,
      ),
    );
  }

  Widget _buildSubtitle(String text) {
    return Text(
      text,
      style: GoogleFonts.cairo(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppTheme.primaryBlue,
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Text(
      text,
      style: GoogleFonts.cairo(
        fontSize: 16,
        height: 1.8,
        color: AppTheme.textPrimary,
      ),
    );
  }

  Widget _buildNote(String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.accentOrange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.accentOrange.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: AppTheme.accentOrange, size: 20),
          const Gap(12),
          Expanded(
            child: Text(
              text,
              style:
                  GoogleFonts.cairo(fontSize: 14, color: AppTheme.textPrimary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarning(String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.warning_outlined, color: Colors.red, size: 20),
          const Gap(12),
          Expanded(
            child: Text(
              text,
              style:
                  GoogleFonts.cairo(fontSize: 14, color: AppTheme.textPrimary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesList(List<String> items, String title) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.primaryBlue.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...items.map(
            (feature) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_circle,
                      color: AppTheme.accentGreen, size: 20),
                  const Gap(8),
                  Expanded(
                    child: Text(
                      feature,
                      style: GoogleFonts.cairo(
                          fontSize: 14, color: AppTheme.textPrimary),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletedList(List<String> items, String? title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null && title.isNotEmpty) _buildSubtitle(title),
        if (title != null && title.isNotEmpty) const Gap(8),
        ...items.map(
          (it) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ',
                    style:
                        TextStyle(color: AppTheme.textPrimary, fontSize: 16)),
                Expanded(
                  child: Text(
                    it,
                    style: GoogleFonts.cairo(
                        fontSize: 14, color: AppTheme.textPrimary, height: 1.6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImages(BuildContext context, List<String> urls, String? width) {
    final validUrls = urls.where((url) => url.isNotEmpty).toList();
    if (validUrls.isEmpty) return const SizedBox.shrink();

    Widget imageRow = validUrls.length == 1
        ? _buildSingleImage(context, validUrls.first)
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: validUrls.map((url) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: _buildSingleImage(context, url),
                ),
              );
            }).toList(),
          );

    // تطبيق العرض المخصص إذا تم تحديده
    if (width != null && width.isNotEmpty) {
      return Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: _parseWidth(width),
          child: imageRow,
        ),
      );
    }

    return imageRow;
  }

  Widget _buildSingleImage(BuildContext context, String url) {
    if (url.isEmpty) return const SizedBox.shrink();
    return GestureDetector(
      onTap: () => _showImageViewer(context, url),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: ExtendedImage.network(
          url,
          fit: BoxFit.cover,
          cache: true,
          loadStateChanged: (state) {
            switch (state.extendedImageLoadState) {
              case LoadState.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case LoadState.completed:
                return ExtendedRawImage(
                  image: state.extendedImageInfo?.image,
                  fit: BoxFit.cover,
                );
              case LoadState.failed:
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: Colors.grey.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.broken_image,
                          size: 48, color: Colors.grey),
                      const Gap(8),
                      Text(
                        'فشل تحميل الصورة',
                        style:
                            GoogleFonts.cairo(fontSize: 14, color: Colors.grey),
                      ),
                      const Gap(4),
                      Text(
                        url,
                        style:
                            GoogleFonts.cairo(fontSize: 11, color: Colors.grey),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }

  void _showImageViewer(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            // Dismiss on tap outside
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                color: Colors.black.withValues(alpha: 0.9),
              ),
            ),
            // Image viewer with zoom
            Center(
              child: ExtendedImageSlidePage(
                child: ExtendedImage.network(
                  url,
                  fit: BoxFit.contain,
                  mode: ExtendedImageMode.gesture,
                  initGestureConfigHandler: (state) {
                    return GestureConfig(
                      minScale: 0.5,
                      maxScale: 4.0,
                      speed: 1.0,
                      inertialSpeed: 100,
                      initialScale: 1.0,
                      inPageView: false,
                    );
                  },
                ),
              ),
            ),
            // Close button
            Positioned(
              top: 40,
              right: 40,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 32,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black.withValues(alpha: 0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideo(String url, double aspectRatio, String? width) {
    if (url.isEmpty) return const SizedBox.shrink();
    final lower = url.toLowerCase();
    String? ytId;
    if (lower.contains('youtube.com') || lower.contains('youtu.be')) {
      ytId = _extractYouTubeId(url);
    }
    final thumb =
        ytId != null ? 'https://img.youtube.com/vi/$ytId/hqdefault.jpg' : null;

    Widget videoWidget = GestureDetector(
      onTap: () => html.window.open(url, '_blank'),
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (thumb != null)
                Image.network(thumb, fit: BoxFit.cover)
              else
                Container(color: Colors.black12),
              Container(color: Colors.black.withValues(alpha: 0.25)),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: const BoxDecoration(
                    color: Colors.white70,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.play_arrow,
                      size: 36, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // تطبيق العرض المخصص إذا تم تحديده
    if (width != null && width.isNotEmpty) {
      return Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          width: _parseWidth(width),
          child: videoWidget,
        ),
      );
    }

    return videoWidget;
  }

  double? _parseWidth(String width) {
    if (width.isEmpty) return null;

    // إذا كانت النسبة المئوية
    if (width.endsWith('%')) {
      final percent = double.tryParse(width.replaceAll('%', '').trim());
      if (percent != null) {
        // استخدام MediaQuery لحساب العرض بناءً على النسبة
        // هنا نفترض عرض أقصى 800px (من ConstrainedBox في ContentPage)
        return (800 * percent / 100);
      }
    }

    // إذا كانت بكسل
    if (width.endsWith('px')) {
      return double.tryParse(width.replaceAll('px', '').trim());
    }

    // محاولة التحليل كرقم مباشر
    return double.tryParse(width);
  }

  String _extractYouTubeId(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return url;
    if (uri.host.contains('youtu.be')) {
      return uri.pathSegments.isNotEmpty ? uri.pathSegments.first : url;
    }
    if (uri.host.contains('youtube.com')) {
      final v = uri.queryParameters['v'];
      if (v != null && v.isNotEmpty) return v;
      final idx = uri.pathSegments.indexOf('embed');
      if (idx != -1 && idx + 1 < uri.pathSegments.length) {
        return uri.pathSegments[idx + 1];
      }
    }
    return url;
  }

  Widget _buildCustom(String id) {
    // Mapping for special, interactive widgets by id
    final map = <String, Widget>{
      // 'audio_demo': AudioVersePlaybackSection(), // example if needed
    };
    if (map.containsKey(id)) return map[id]!;
    return _buildWarning('# Unknown custom widget: $id');
  }
}

class _NestedSectionView extends StatelessWidget {
  final SectionModel section;
  final int depth;
  final Set<String> visited;
  const _NestedSectionView(
      {required this.section, required this.depth, required this.visited});
  @override
  Widget build(BuildContext context) {
    final contentCtrl = ContentController.instance;
    final lang = contentCtrl.currentLang;
    final fallback = contentCtrl.defaultLang;
    final indent = depth * 16.0;
    return Container(
      padding: EdgeInsetsDirectional.only(start: indent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.title.resolve(lang, fallbackLang: fallback),
            style: GoogleFonts.cairo(
              fontSize: 20 - (depth * 1.5).clamp(0, 8),
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryBlue.withValues(alpha: 0.9 - depth * 0.1),
            ),
          ),
          const Gap(12),
          ...section.blocks.expand((b) => [
                Builder(
                  builder: (ctx) => DynamicSectionPage(section: section)
                      ._buildBlock(ctx, b, lang, fallback),
                ),
                const Gap(12),
              ]),
          if (section.children.isNotEmpty)
            ...section.children.expand((cid) {
              if (visited.contains(cid)) {
                return [
                  _buildCycleWarning(),
                ];
              }
              final child = contentCtrl.content?.sectionsById[cid];
              if (child == null) return [const SizedBox.shrink()];
              final nextVisited = {...visited, section.id};
              return [
                const Gap(8),
                _NestedSectionView(
                    section: child, depth: depth + 1, visited: nextVisited),
              ];
            }),
        ],
      ),
    );
  }

  Widget _buildCycleWarning() {
    return Row(
      children: [
        const Icon(Icons.error_outline, color: Colors.red, size: 16),
        const Gap(6),
        Text(
          'تم تجاهل حلقة أقسام متبادلة',
          style: GoogleFonts.cairo(fontSize: 12, color: Colors.red),
        ),
      ],
    );
  }
}
