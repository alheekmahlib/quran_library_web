import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_theme.dart';

abstract class BaseSectionPage extends StatelessWidget {
  const BaseSectionPage({super.key});

  // Helper widgets shared across all sections
  Widget buildTitle(String title) {
    return Text(
      title.tr,
      style: GoogleFonts.cairo(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: AppTheme.textPrimary,
      ),
    );
  }

  Widget buildSubtitle(String subtitle) {
    return Text(
      subtitle.tr,
      style: GoogleFonts.cairo(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppTheme.primaryBlue,
      ),
    );
  }

  Widget buildParagraph(String text) {
    return Text(
      text.tr,
      style: GoogleFonts.cairo(
        fontSize: 16,
        height: 1.8,
        color: AppTheme.textPrimary,
      ),
    );
  }

  Widget buildHighlightBox(String text) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryBlue.withValues(alpha: 0.1),
            AppTheme.arabicGreen.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.primaryBlue.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        text.tr,
        style: GoogleFonts.cairo(
          fontSize: 16,
          height: 1.6,
          color: AppTheme.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget buildNote([String? title, String? customText]) {
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
          Icon(
            Icons.info_outline,
            color: AppTheme.accentOrange,
            size: 20,
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  Text(
                    '${'important_note'.tr}${title.isNotEmpty ? ' - ${title.tr}' : ''}:',
                    style: GoogleFonts.cairo(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.accentOrange,
                    ),
                  ),
                  const Gap(4),
                ],
                Text(
                  customText?.tr ?? 'material3_note'.tr,
                  style: GoogleFonts.cairo(
                    fontSize: 14,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWarning([String? title, String? customText]) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.red.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.warning_outlined,
            color: Colors.red,
            size: 20,
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  Text(
                    '${'warning'.tr}${title.isNotEmpty ? ' - ${title.tr}' : ''}:',
                    style: GoogleFonts.cairo(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                  const Gap(4),
                ],
                Text(
                  customText?.tr ?? 'android_warning'.tr,
                  style: GoogleFonts.cairo(
                    fontSize: 14,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFeaturesList(List<String> features, String title) {
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
          Text(
            title.tr,
            style: GoogleFonts.cairo(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryBlue,
            ),
          ),
          const Gap(12),
          ...features.map(
            (feature) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: AppTheme.accentGreen,
                    size: 20,
                  ),
                  const Gap(8),
                  Expanded(
                    child: Text(
                      feature.tr,
                      style: GoogleFonts.cairo(
                        fontSize: 14,
                        color: AppTheme.textPrimary,
                      ),
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
}
