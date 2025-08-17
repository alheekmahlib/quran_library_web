import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors inspired by Riverpod
  static const Color primaryBlue = Color(0xFF1976D2);
  static const Color darkBlue = Color(0xFF0D47A1);
  static const Color lightBlue = Color(0xFF42A5F5);
  static const Color backgroundColor = Color(0xFF0F1419);
  static const Color surfaceColor = Color(0xFF1E2328);
  static const Color cardColor = Color(0xFF2A2F36);
  static const Color cardDarkColor = Color.fromARGB(255, 30, 30, 30);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0BEC5);
  static const Color accentGreen = Color(0xFF4CAF50);
  static const Color accentOrange = Color(0xFFFF9800);

  // Arabic colors
  static const Color arabicGold = Color(0xFFFFD700);
  static const Color arabicGreen = Color(0xFF228B22);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: MaterialColor(primaryBlue.value, {
        50: lightBlue.withValues(alpha: 0.1),
        100: lightBlue.withValues(alpha: 0.2),
        200: lightBlue.withValues(alpha: 0.3),
        300: lightBlue.withValues(alpha: 0.4),
        400: lightBlue.withValues(alpha: 0.6),
        500: primaryBlue,
        600: darkBlue.withValues(alpha: 0.8),
        700: darkBlue,
        800: darkBlue.withValues(alpha: 0.9),
        900: darkBlue,
      }),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.cairo(
          color: textPrimary,
          fontSize: 57,
          fontWeight: FontWeight.w400,
        ),
        displayMedium: GoogleFonts.cairo(
          color: textPrimary,
          fontSize: 45,
          fontWeight: FontWeight.w400,
        ),
        displaySmall: GoogleFonts.cairo(
          color: textPrimary,
          fontSize: 36,
          fontWeight: FontWeight.w400,
        ),
        headlineLarge: GoogleFonts.cairo(
          color: textPrimary,
          fontSize: 32,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: GoogleFonts.cairo(
          color: textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: GoogleFonts.cairo(
          color: textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: GoogleFonts.cairo(
          color: textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
        titleMedium: GoogleFonts.cairo(
          color: textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: GoogleFonts.cairo(
          color: textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: GoogleFonts.cairo(
          color: textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: GoogleFonts.cairo(
          color: textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: GoogleFonts.cairo(
          color: textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
      cardTheme: CardTheme(
        color: cardColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: textPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  static TextStyle get arabicTextStyle {
    return GoogleFonts.cairo(
      fontSize: 18,
      color: textPrimary,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle get codeStyle {
    return GoogleFonts.cairo(
      fontSize: 14,
      color: textPrimary,
      backgroundColor: cardColor,
    );
  }
}
