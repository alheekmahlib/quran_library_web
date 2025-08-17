import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../widgets/code_block.dart';
import 'base_section_page.dart';

class CompleteAudioExampleSection extends BaseSectionPage {
  const CompleteAudioExampleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle('complete_audio_example'.tr),
        const Gap(16),
        buildParagraph(
            'Complete example showing all audio features in one implementation.\nمثال شامل يُظهر جميع الميزات الصوتية في تطبيق واحد.'),
        const Gap(16),
        const CodeBlock(
          code: '''class AudioControlExample extends StatefulWidget {
  @override
  _AudioControlExampleState createState() => _AudioControlExampleState();
}

class _AudioControlExampleState extends State<AudioControlExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('مشغل القرآن الصوتي')),
      body: Column(
        children: [
          // عرض السورة الحالية
          Text('السورة الحالية: \${QuranLibrary().currentAndLastSurahNumber}'),
          
          // عرض الموضع الأخير
          Text('الموضع الأخير: \${QuranLibrary().formatLastPositionToTime}'),
          
          // أزرار التحكم
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // تشغيل من الموضع الأخير
              ElevatedButton(
                onPressed: () => QuranLibrary().playLastPosition(),
                child: Text('متابعة من حيث توقفت'),
              ),
              
              // تشغيل سورة الفاتحة
              ElevatedButton(
                onPressed: () => QuranLibrary().playSurah(surahNumber: 1),
                child: Text('سورة الفاتحة'),
              ),
            ],
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // السورة السابقة
              IconButton(
                onPressed: () => QuranLibrary().seekToPreviousSurah(),
                icon: Icon(Icons.skip_previous),
              ),
              
              // الآية السابقة
              IconButton(
                onPressed: () => QuranLibrary().seekPreviousAyah(
                  context: context,
                  currentAyahUniqueNumber: 10,
                ),
                icon: Icon(Icons.fast_rewind),
              ),
              
              // الآية التالية
              IconButton(
                onPressed: () => QuranLibrary().seekNextAyah(
                  context: context,
                  currentAyahUniqueNumber: 5,
                ),
                icon: Icon(Icons.fast_forward),
              ),
              
              // السورة التالية
              IconButton(
                onPressed: () => QuranLibrary().seekToNextSurah(),
                icon: Icon(Icons.skip_next),
              ),
            ],
          ),
          
          // أزرار التحميل
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => QuranLibrary().startDownloadSurah(surahNumber: 2),
                child: Text('تحميل سورة البقرة'),
              ),
              
              ElevatedButton(
                onPressed: () => QuranLibrary().cancelDownloadSurah(),
                child: Text('إلغاء التحميل'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}''',
          language: 'dart',
        ),
        const Gap(24),
        buildSubtitle('audio_features_summary'.tr),
        const Gap(16),
        buildParagraph('audio_feature_verse'.tr),
        const Gap(8),
        buildParagraph('audio_feature_surah'.tr),
        const Gap(8),
        buildParagraph('audio_feature_navigation'.tr),
        const Gap(8),
        buildParagraph('audio_feature_offline'.tr),
        const Gap(8),
        buildParagraph('audio_feature_resume'.tr),
        const Gap(8),
        buildParagraph('audio_feature_background'.tr),
        const Gap(8),
        buildParagraph('audio_feature_tracking'.tr),
        const Gap(8),
        buildParagraph('audio_feature_management'.tr),
        const Gap(16),
        buildNote(null,
            'This example demonstrates the complete audio playback system.\nهذا المثال يُظهر نظام التشغيل الصوتي الشامل.'),
      ],
    );
  }
}
