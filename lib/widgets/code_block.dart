import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/vs2015.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_theme.dart';

class CodeBlock extends StatefulWidget {
  final String code;
  final String language;
  final bool showCopyButton;
  final double fontSize;

  const CodeBlock({
    super.key,
    required this.code,
    this.language = 'dart',
    this.showCopyButton = true,
    this.fontSize = 14,
  });

  @override
  State<CodeBlock> createState() => _CodeBlockState();
}

class _CodeBlockState extends State<CodeBlock> {
  bool _copied = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardDarkColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.cardColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header with language and copy button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.backgroundColor.withValues(alpha: 0.5),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.language.toUpperCase(),
                  style: GoogleFonts.cairo(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textSecondary,
                  ),
                ),
                if (widget.showCopyButton)
                  InkWell(
                    onTap: _copyToClipboard,
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _copied ? Icons.check : Icons.copy,
                            size: 16,
                            color: _copied
                                ? AppTheme.accentGreen
                                : AppTheme.textSecondary,
                          ),
                          const Gap(4),
                          Text(
                            _copied ? 'copied'.tr : 'copy'.tr,
                            style: GoogleFonts.cairo(
                              fontSize: 12,
                              color: _copied
                                  ? AppTheme.accentGreen
                                  : AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Code content
          Directionality(
            textDirection: TextDirection.ltr,
            child: SelectionArea(
              child: HighlightView(
                widget.code,
                language: widget.language,
                theme: vs2015Theme,
                padding: const EdgeInsets.all(16),
                textStyle: GoogleFonts.firaCode(
                  fontSize: widget.fontSize,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: widget.code));
    setState(() {
      _copied = true;
    });

    // Reset after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _copied = false;
        });
      }
    });
  }
}
