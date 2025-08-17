import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../widgets/code_block.dart';
import 'base_section_page.dart';

class BasicQuranScreenSection extends BaseSectionPage {
  const BasicQuranScreenSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle('basic_quran_screen'.tr),
        const Gap(16),
        buildParagraph('basic_quran_simple'.tr),
        const Gap(16),
        CodeBlock(
          language: 'dart',
          code: '''/// You can just add it to your code like this:
/// يمكنك فقط إضافته إلى الكود الخاص بك هكذا:
class MyQuranPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return QuranLibraryScreen(
      parentContext: context, // مطلوب - Required
    );
  }
}''',
        ),
        const Gap(24),
        buildSubtitle('advanced_options'.tr),
        const Gap(16),
        buildParagraph('advanced_options_description'.tr),
        const Gap(16),
        CodeBlock(
          language: 'dart',
          code: '''QuranLibraryScreen(
    /// **مطلوب** - تمرير السياق من الويدجت الأب [parentContext]
    /// **Required** - Pass context from parent widget [parentContext]
    parentContext: context,
    
    /// إذا قمت بإضافة شريط التطبيقات هنا فإنه سيحل محل شريط التطبيقات الافتراضية [appBar]
    /// [appBar] if if provided it will replace the default app bar
    appBar: ...,
    /// متغير لتعطيل أو تمكين شريط التطبيقات الافتراضية [useDefaultAppBar]
    /// [useDefaultAppBar] is a bool to disable or enable the default app bar widget
    useDefaultAppBar: // true or false,
    /// إذا تم توفيره فسيتم استدعاؤه عند تغيير صفحة القرآن [onPageChanged]
    /// [onPageChanged] if provided it will be called when a quran page changed
    onPageChanged: (int pageIndex) => print("Page changed: \$pageIndex"),
    /// تغيير نمط البسملة بواسطة هذه الفئة [BasmalaStyle]
    /// [BasmalaStyle] Change the style of Basmala by BasmalaStyle class
    basmalaStyle: // BasmalaStyle(),
    /// تغيير نمط الشعار من خلال هذه الفئة [BannerStyle]
    /// [BannerStyle] Change the style of banner by BannerStyle class
    bannerStyle: // BannerStyle(),
    /// تغيير نمط اسم السورة بهذه الفئة [SurahNameStyle]
    /// [SurahNameStyle] Change the style of surah name by SurahNameStyle class
    surahNameStyle: // SurahNameStyle(),
    /// تغيير نمط معلومات السورة بواسطة هذه الفئة [SurahInfoStyle]
    /// [SurahInfoStyle] Change the style of surah information by SurahInfoStyle class
    surahInfoStyle: // SurahInfoStyle(),
    /// تغيير نمط نافذة تحميل الخطوط بواسطة هذه الفئة [DownloadFontsDialogStyle]
    /// [DownloadFontsDialogStyle] Change the style of Download fonts dialog by DownloadFontsDialogStyle class
    downloadFontsDialogStyle: // DownloadFontsDialogStyle(),
    
    /// and more ................
),''',
        ),
        const Gap(16),
        buildNote(null, 'basic_screen_note'),
      ],
    );
  }
}
