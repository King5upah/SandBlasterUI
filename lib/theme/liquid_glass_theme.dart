import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LiquidGlassTheme {
  // Background colors
  static const Color bgDeep = Color(0xFF050814);
  static const Color bgMid = Color(0xFF0A0F2E);
  static const Color bgSurface = Color(0xFF0D1240);

  // Accent orb colors
  static const Color orbBlue = Color(0xFF3B82F6);
  static const Color orbViolet = Color(0xFF7C3AED);
  static const Color orbCyan = Color(0xFF06B6D4);
  static const Color orbPink = Color(0xFFEC4899);
  static const Color orbEmerald = Color(0xFF10B981);

  // Glass surface colors
  static const Color glassSurface = Color(0x18FFFFFF);
  static const Color glassElevated = Color(0x28FFFFFF);
  static const Color glassOverlay = Color(0x38FFFFFF);
  static const Color glassBorder = Color(0x30FFFFFF);
  static const Color glassHighlight = Color(0x50FFFFFF);
  static const Color glassShadow = Color(0x40000000);

  // Text colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xB3FFFFFF);
  static const Color textTertiary = Color(0x66FFFFFF);

  // Accent
  static const Color accent = Color(0xFF60A5FA);
  static const Color accentGlow = Color(0x4060A5FA);
  static const Color accentViolet = Color(0xFFA78BFA);
  static const Color success = Color(0xFF34D399);
  static const Color warning = Color(0xFFFBBF24);
  static const Color error = Color(0xFFF87171);

  // Blur levels
  static const double blurLight = 8.0;
  static const double blurMedium = 20.0;
  static const double blurHeavy = 40.0;

  // Border radius
  static const double radiusSm = 12.0;
  static const double radiusMd = 18.0;
  static const double radiusLg = 24.0;
  static const double radiusXl = 32.0;
  static const double radiusPill = 999.0;

  static ThemeData get themeData => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bgDeep,
        colorScheme: const ColorScheme.dark(
          primary: accent,
          secondary: accentViolet,
          surface: bgSurface,
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
          displayLarge: GoogleFonts.inter(
            fontSize: 48,
            fontWeight: FontWeight.w700,
            color: textPrimary,
            letterSpacing: -1.5,
          ),
          displayMedium: GoogleFonts.inter(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: textPrimary,
            letterSpacing: -1.0,
          ),
          headlineLarge: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: textPrimary,
            letterSpacing: -0.5,
          ),
          headlineMedium: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: textPrimary,
          ),
          titleLarge: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: textPrimary,
          ),
          titleMedium: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textPrimary,
          ),
          bodyLarge: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: textSecondary,
          ),
          bodyMedium: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: textSecondary,
          ),
          labelLarge: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: textPrimary,
            letterSpacing: 0.5,
          ),
          labelMedium: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: textSecondary,
            letterSpacing: 0.3,
          ),
        ),
      );
}
