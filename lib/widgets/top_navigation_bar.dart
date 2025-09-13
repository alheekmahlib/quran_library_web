import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_constants.dart';
import '../constants/app_theme.dart';
import 'language_dropdown.dart';
import 'search_widget.dart';

class TopNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  const TopNavigationBar({super.key});

  bool get _isMobile {
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    final screenWidth = view.physicalSize.width / view.devicePixelRatio;
    return screenWidth <= 800;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 800;

    return AppBar(
      backgroundColor: AppTheme.backgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false, // Disable automatic leading widget
      toolbarHeight:
          isMobile ? 110 : 70, // Different heights for mobile and desktop
      flexibleSpace: SafeArea(
        child: isMobile
            ? _buildMobileLayout(context)
            : _buildDesktopLayout(context),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Logo
          Image.network(
            AppConstants.libraryLogoUrl,
            height: 45,
            width: 45,
          ),
          const Gap(12),
          Text(
            'app_title'.tr,
            style: GoogleFonts.cairo(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          const Spacer(),
          // Navigation items for desktop
          // _buildNavItem('docs'.tr, () {}),
          const Gap(16),
          // Language dropdown
          const LanguageDropdown(),
          const Gap(16),
          _buildIconButton(
            Icons.code,
            'GitHub',
            () => _launchUrl(AppConstants.githubUrl),
          ),
          const Gap(8),
          SearchWidget(isMobile: false),
          const Gap(16),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          // First row: Logo, title, and menu button
          SizedBox(
            height: 50,
            child: Row(
              children: [
                // Logo
                Image.network(
                  AppConstants.libraryLogoUrl,
                  height: 45,
                  width: 45,
                ),
                const Gap(12),
                Expanded(
                  child: Text(
                    'app_title'.tr,
                    style: GoogleFonts.cairo(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Second row: Language dropdown and search
          SizedBox(
            height: 40,
            child: Row(
              children: [
                // Language dropdown
                const LanguageDropdown(),
                const Gap(16),
                // Search button
                SearchWidget(isMobile: true),
                const Gap(16),
                // GitHub button
                _buildIconButton(
                  Icons.code,
                  'GitHub',
                  () => _launchUrl(AppConstants.githubUrl),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          text,
          style: GoogleFonts.cairo(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppTheme.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String tooltip, VoidCallback onTap) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            color: AppTheme.textSecondary,
            size: 20,
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(_isMobile ? 110 : 70);
}
