import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../widgets/code_block.dart';
import 'base_section_page.dart';

class DownloadQuranFontsSection extends BaseSectionPage {
  const DownloadQuranFontsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle('fonts_download'.tr),
        const Gap(16),
        buildParagraph('fonts_download_enhanced'.tr),
        const Gap(16),
        buildSubtitle('download_options'.tr),
        const Gap(12),
        buildParagraph('fonts_option_1'.tr),
        const Gap(8),
        buildParagraph('fonts_option_2'.tr),
        const Gap(24),
        buildSubtitle('macos_requirements'.tr),
        const Gap(12),
        buildParagraph('macos_instructions'.tr),
        const Gap(16),
        const CodeBlock(
          code: '''<key>com.apple.security.network.client</key>
<true/>''',
          language: 'xml',
        ),
        const Gap(24),
        buildSubtitle('fonts_methods_available'.tr),
        const Gap(16),
        const CodeBlock(
          code: '''///
/// to get the fonts download dialog just call [getFontsDownloadDialog]
///
/// and pass the language code to translate the number if you want,
/// the default language code is 'ar' [languageCode]
/// and style [DownloadFontsDialogStyle] is optional.
/// للحصول على نافذة حوار خاصة بتحميل الخطوط، قم فقط باستدعاء: [getFontsDownloadDialog].
///
/// قم بتمرير رمز اللغة ليتم عرض الأرقام على حسب اللغة،
/// رمز اللغة الإفتراضي هو: 'ar' [languageCode].
/// كما أن التمرير الاختياري لنمط [DownloadFontsDialogStyle] ممكن.
QuranLibrary().getFontsDownloadDialog(downloadFontsDialogStyle, languageCode);

/// للحصول على الويدجت الخاصة بتنزيل الخطوط فقط قم بإستدعاء [getFontsDownloadWidget]
///
/// to get the fonts download widget just call [getFontsDownloadWidget]
Widget getFontsDownloadWidget(context, {downloadFontsDialogStyle, languageCode});

/// للحصول على طريقة تنزيل الخطوط فقط قم بإستدعاء [fontsDownloadMethod]
///
/// to get the fonts download method just call [fontsDownloadMethod]
QuranLibrary().fontsDownloadMethod;

/// للحصول على طريقة تنزيل الخطوط فقط قم بإستدعاء [getFontsPrepareMethod]
/// مطلوب تمرير رقم الصفحة [pageIndex]
///
/// to prepare the fonts was downloaded before just call [getFontsPrepareMethod]
/// required to pass [pageIndex]
QuranLibrary().getFontsPrepareMethod(pageIndex);

/// لحذف الخطوط فقط قم بإستدعاء [deleteFontsMethod]
///
/// to delete the fonts just call [deleteFontsMethod]
QuranLibrary().deleteFontsMethod;

/// للحصول على تقدم تنزيل الخطوط، ما عليك سوى إستدعاء [fontsDownloadProgress]
///
/// to get fonts download progress just call [fontsDownloadProgress]
QuranLibrary().fontsDownloadProgress;

/// لمعرفة ما إذا كانت الخطوط محملة او لا، ما عليك سوى إستدعاء [isFontsDownloaded]
///
/// To find out whether fonts are downloaded or not, just call [isFontsDownloaded]
QuranLibrary().isFontsDownloaded;''',
          language: 'dart',
        ),
        const Gap(16),
        buildNote(null, 'fonts_download_note'.tr),
      ],
    );
  }
}
