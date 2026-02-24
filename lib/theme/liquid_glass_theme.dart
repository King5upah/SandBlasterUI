import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SandblasterThemeData extends ThemeExtension<SandblasterThemeData> {
  final Color bgDeep;
  final Color bgMid;
  final Color bgSurface;
  final Color orbBlue;
  final Color orbViolet;
  final Color orbCyan;
  final Color orbPink;
  final Color orbEmerald;
  final Color glassSurface;
  final Color glassElevated;
  final Color glassOverlay;
  final Color glassBorder;
  final Color glassHighlight;
  final Color glassShadow;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color accent;
  final Color accentGlow;
  final Color accentViolet;
  final Color success;
  final Color warning;
  final Color error;

  const SandblasterThemeData({
    required this.bgDeep,
    required this.bgMid,
    required this.bgSurface,
    required this.orbBlue,
    required this.orbViolet,
    required this.orbCyan,
    required this.orbPink,
    required this.orbEmerald,
    required this.glassSurface,
    required this.glassElevated,
    required this.glassOverlay,
    required this.glassBorder,
    required this.glassHighlight,
    required this.glassShadow,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.accent,
    required this.accentGlow,
    required this.accentViolet,
    required this.success,
    required this.warning,
    required this.error,
  });

  @override
  SandblasterThemeData copyWith({
    Color? bgDeep,
    Color? bgMid,
    Color? bgSurface,
    Color? orbBlue,
    Color? orbViolet,
    Color? orbCyan,
    Color? orbPink,
    Color? orbEmerald,
    Color? glassSurface,
    Color? glassElevated,
    Color? glassOverlay,
    Color? glassBorder,
    Color? glassHighlight,
    Color? glassShadow,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? accent,
    Color? accentGlow,
    Color? accentViolet,
    Color? success,
    Color? warning,
    Color? error,
  }) {
    return SandblasterThemeData(
      bgDeep: bgDeep ?? this.bgDeep,
      bgMid: bgMid ?? this.bgMid,
      bgSurface: bgSurface ?? this.bgSurface,
      orbBlue: orbBlue ?? this.orbBlue,
      orbViolet: orbViolet ?? this.orbViolet,
      orbCyan: orbCyan ?? this.orbCyan,
      orbPink: orbPink ?? this.orbPink,
      orbEmerald: orbEmerald ?? this.orbEmerald,
      glassSurface: glassSurface ?? this.glassSurface,
      glassElevated: glassElevated ?? this.glassElevated,
      glassOverlay: glassOverlay ?? this.glassOverlay,
      glassBorder: glassBorder ?? this.glassBorder,
      glassHighlight: glassHighlight ?? this.glassHighlight,
      glassShadow: glassShadow ?? this.glassShadow,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      accent: accent ?? this.accent,
      accentGlow: accentGlow ?? this.accentGlow,
      accentViolet: accentViolet ?? this.accentViolet,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
    );
  }

  @override
  SandblasterThemeData lerp(ThemeExtension<SandblasterThemeData>? other, double t) {
    if (other is! SandblasterThemeData) return this;
    return SandblasterThemeData(
      bgDeep: Color.lerp(bgDeep, other.bgDeep, t)!,
      bgMid: Color.lerp(bgMid, other.bgMid, t)!,
      bgSurface: Color.lerp(bgSurface, other.bgSurface, t)!,
      orbBlue: Color.lerp(orbBlue, other.orbBlue, t)!,
      orbViolet: Color.lerp(orbViolet, other.orbViolet, t)!,
      orbCyan: Color.lerp(orbCyan, other.orbCyan, t)!,
      orbPink: Color.lerp(orbPink, other.orbPink, t)!,
      orbEmerald: Color.lerp(orbEmerald, other.orbEmerald, t)!,
      glassSurface: Color.lerp(glassSurface, other.glassSurface, t)!,
      glassElevated: Color.lerp(glassElevated, other.glassElevated, t)!,
      glassOverlay: Color.lerp(glassOverlay, other.glassOverlay, t)!,
      glassBorder: Color.lerp(glassBorder, other.glassBorder, t)!,
      glassHighlight: Color.lerp(glassHighlight, other.glassHighlight, t)!,
      glassShadow: Color.lerp(glassShadow, other.glassShadow, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentGlow: Color.lerp(accentGlow, other.accentGlow, t)!,
      accentViolet: Color.lerp(accentViolet, other.accentViolet, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
    );
  }

  // Pre-defined Themes
  static const dark = SandblasterThemeData(
    bgDeep: Color(0xFF050814),
    bgMid: Color(0xFF0A0F2E),
    bgSurface: Color(0xFF0D1240),
    orbBlue: Color(0xFF3B82F6),
    orbViolet: Color(0xFF7C3AED),
    orbCyan: Color(0xFF06B6D4),
    orbPink: Color(0xFFEC4899),
    orbEmerald: Color(0xFF10B981),
    glassSurface: Color(0x18FFFFFF),
    glassElevated: Color(0x28FFFFFF),
    glassOverlay: Color(0x38FFFFFF),
    glassBorder: Color(0x30FFFFFF),
    glassHighlight: Color(0x50FFFFFF),
    glassShadow: Color(0x40000000),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xB3FFFFFF),
    textTertiary: Color(0x66FFFFFF),
    accent: Color(0xFF60A5FA),
    accentGlow: Color(0x4060A5FA),
    accentViolet: Color(0xFFA78BFA),
    success: Color(0xFF34D399),
    warning: Color(0xFFFBBF24),
    error: Color(0xFFF87171),
  );

  static const light = SandblasterThemeData(
    bgDeep: Color(0xFFF0F4FC),
    bgMid: Color(0xFFE2E8F0),
    bgSurface: Color(0xFFCBD5E1),
    orbBlue: Color(0xFFBFDBFE),
    orbViolet: Color(0xFFE9D5FF),
    orbCyan: Color(0xFFCFFAFE),
    orbPink: Color(0xFFFBCFE8),
    orbEmerald: Color(0xFFD1FAE5),
    glassSurface: Color(0x33FFFFFF),
    glassElevated: Color(0x4DFFFFFF),
    glassOverlay: Color(0x66FFFFFF),
    glassBorder: Color(0x80FFFFFF),
    glassHighlight: Color(0x99FFFFFF),
    glassShadow: Color(0x1A000000),
    textPrimary: Color(0xFF0F172A),
    textSecondary: Color(0xFF334155),
    textTertiary: Color(0xFF64748B),
    accent: Color(0xFF2563EB),
    accentGlow: Color(0x402563EB),
    accentViolet: Color(0xFF7C3AED),
    success: Color(0xFF059669),
    warning: Color(0xFFD97706),
    error: Color(0xFFDC2626),
  );

  static const ruby = SandblasterThemeData(
    bgDeep: Color(0xFF1F0004),
    bgMid: Color(0xFF3B0008),
    bgSurface: Color(0xFF4C000B),
    orbBlue: Color(0xFFFF4D6D),
    orbViolet: Color(0xFFFF758F),
    orbCyan: Color(0xFFFF8FA3),
    orbPink: Color(0xFFFFB3C1),
    orbEmerald: Color(0xFFFFCCD5),
    glassSurface: Color(0x18FFFFFF),
    glassElevated: Color(0x28FFFFFF),
    glassOverlay: Color(0x38FFFFFF),
    glassBorder: Color(0x40FFFFFF),
    glassHighlight: Color(0x60FFFFFF),
    glassShadow: Color(0x60000000),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xE6FFFFFF),
    textTertiary: Color(0x99FFFFFF),
    accent: Color(0xFFFF1A40),
    accentGlow: Color(0x40FF1A40),
    accentViolet: Color(0xFFFF4060),
    success: Color(0xFFFFFFFF),
    warning: Color(0xFFFFB3C1),
    error: Color(0xFFFFFFFF),
  );

  static const latte = SandblasterThemeData(
    bgDeep: Color(0xFFEBE3D5),
    bgMid: Color(0xFFDED0B6),
    bgSurface: Color(0xFFB2A59B),
    orbBlue: Color(0xFFD2B48C),
    orbViolet: Color(0xFFC19A6B),
    orbCyan: Color(0xFFE8D0A9),
    orbPink: Color(0xFFB59A7C),
    orbEmerald: Color(0xFF8B7355),
    glassSurface: Color(0x33FFFFFF),
    glassElevated: Color(0x4DFFFFFF),
    glassOverlay: Color(0x66FFFFFF),
    glassBorder: Color(0x99FFFFFF),
    glassHighlight: Color(0x99FFFFFF),
    glassShadow: Color(0x153C2A21),
    textPrimary: Color(0xFF3C2A21),
    textSecondary: Color(0xFF604A3C),
    textTertiary: Color(0xFF8A7769),
    accent: Color(0xFFD0B8A8),
    accentGlow: Color(0x40D0B8A8),
    accentViolet: Color(0xFFAB8A72),
    success: Color(0xFF6A994E),
    warning: Color(0xFFD4A373),
    error: Color(0xFFBC4749),
  );
}

class LiquidGlassTheme {
  // Constant values remain static
  static const double blurLight = 8.0;
  static const double blurMedium = 20.0;
  static const double blurHeavy = 40.0;
  
  static const double radiusSm = 12.0;
  static const double radiusMd = 18.0;
  static const double radiusLg = 24.0;
  static const double radiusXl = 32.0;
  static const double radiusPill = 999.0;

  static ThemeData get darkTheme => _buildTheme(Brightness.dark, SandblasterThemeData.dark);
  static ThemeData get lightTheme => _buildTheme(Brightness.light, SandblasterThemeData.light);
  static ThemeData get rubyTheme => _buildTheme(Brightness.dark, SandblasterThemeData.ruby);
  static ThemeData get latteTheme => _buildTheme(Brightness.light, SandblasterThemeData.latte);

  static ThemeData _buildTheme(Brightness brightness, SandblasterThemeData ext) {
    final baseTextTheme = brightness == Brightness.dark
        ? ThemeData.dark().textTheme
        : ThemeData.light().textTheme;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: ext.bgDeep,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ext.accent,
        brightness: brightness,
        surface: ext.bgSurface,
      ),
      extensions: [ext],
      textTheme: GoogleFonts.interTextTheme(baseTextTheme).copyWith(
        displayLarge: GoogleFonts.inter(
          fontSize: 48,
          fontWeight: FontWeight.w700,
          color: ext.textPrimary,
          letterSpacing: -1.5,
        ),
        displayMedium: GoogleFonts.inter(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          color: ext.textPrimary,
          letterSpacing: -1.0,
        ),
        headlineLarge: GoogleFonts.inter(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: ext.textPrimary,
          letterSpacing: -0.5,
        ),
        headlineMedium: GoogleFonts.inter(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: ext.textPrimary,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: ext.textPrimary,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: ext.textPrimary,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: ext.textSecondary,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: ext.textSecondary,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: ext.textPrimary,
          letterSpacing: 0.5,
        ),
        labelMedium: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: ext.textSecondary,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

extension SandblasterThemeExtension on BuildContext {
  SandblasterThemeData get sbTheme => Theme.of(this).extension<SandblasterThemeData>() ?? SandblasterThemeData.dark;
}
