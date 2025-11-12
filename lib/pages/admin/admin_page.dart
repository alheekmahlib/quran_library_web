import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_theme.dart';
import '../../controllers/admin_controller.dart';
import '../../controllers/content_controller.dart';
import '../../core/content/content_repository.dart';
import '../../core/content/platform/content_platform_stub.dart'
    if (dart.library.html) '../../core/content/platform/content_platform_web.dart';
import 'widgets/admin_sidebar.dart';
import 'widgets/preview_panel.dart';
import 'widgets/section_editor.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<AdminController>()) {
      Get.put(AdminController());
    }
    final admin = AdminController.instance;
    final contentCtrl = ContentController.instance;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text('لوحة تحكم المحتوى', style: GoogleFonts.cairo()),
        backgroundColor: AppTheme.surfaceColor,
        actions: [
          Tooltip(
            message: 'إضافة اللغات الناقصة (ar/en/bn/id/ur/tr/ku/ms/es)',
            child: IconButton(
              icon: const Icon(Icons.language),
              onPressed: () {
                AdminController.instance.ensureAllLanguagesExpose();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('تمت مزامنة جميع اللغات في المحتوى')),
                );
              },
            ),
          ),
          IconButton(
            tooltip: 'استيراد JSON',
            icon: const Icon(Icons.file_open),
            onPressed: () async {
              try {
                final picked = await ContentPlatform().pickJsonFile();
                if (picked == null) return;
                final ok =
                    await ContentRepository.instance.saveLocalAndApply(picked);
                if (ok) {
                  await contentCtrl.load();
                  admin.loadFromAppContent();
                  _showSnack(context, 'تم الاستيراد بنجاح');
                } else {
                  _showSnack(context, 'فشل الاستيراد: صيغة غير صالحة',
                      isError: true);
                }
              } catch (e) {
                _showSnack(context, 'خطأ أثناء الاستيراد: $e', isError: true);
              }
            },
          ),
          IconButton(
            tooltip: 'تصدير JSON',
            icon: const Icon(Icons.download),
            onPressed: () async {
              try {
                final c = admin.content;
                if (c == null) return;
                final encoder = const JsonEncoder.withIndent('  ');
                final jsonStr = encoder.convert(c.toJson());
                ContentPlatform().downloadJson('content.json', jsonStr);
              } catch (e) {
                _showSnack(context, 'خطأ أثناء التصدير: $e', isError: true);
              }
            },
          ),
          IconButton(
            tooltip: 'إعادة التحميل من المصدر',
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await contentCtrl.load();
              admin.loadFromAppContent();
              _showSnack(context, 'تم إعادة التحميل');
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Obx(() {
        final c = admin.content;
        if (c == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Row(
          children: [
            Container(
                width: 280,
                color: AppTheme.surfaceColor,
                child: const AdminSidebar()),
            Container(width: 1, color: AppTheme.cardColor),
            const Expanded(flex: 3, child: SectionEditor()),
            Container(width: 1, color: AppTheme.cardColor),
            const Expanded(flex: 3, child: PreviewPanel()),
          ],
        );
      }),
    );
  }

  void _showSnack(BuildContext context, String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: GoogleFonts.cairo()),
      backgroundColor: isError ? Colors.red : AppTheme.primaryBlue,
    ));
  }
}

// تم نقل المكوّنات إلى ملفات فرعية داخل pages/admin/widgets/
