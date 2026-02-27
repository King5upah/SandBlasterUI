import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SandblasterThemeData extends ThemeExtension<SandblasterThemeData> {
  final Color bgDeep;
  final Color bgMid;
  final Color bgSurface;
  final Color bgHighlight;
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
  final bool useOpaqueBackground;

  const SandblasterThemeData({
    required this.bgDeep,
    required this.bgMid,
    required this.bgSurface,
    required this.bgHighlight,
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
    this.useOpaqueBackground = false,
  });

  @override
  SandblasterThemeData copyWith({
    Color? bgDeep,
    Color? bgMid,
    Color? bgSurface,
    Color? bgHighlight,
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
    bool? useOpaqueBackground,
  }) {
    return SandblasterThemeData(
      bgDeep: bgDeep ?? this.bgDeep,
      bgMid: bgMid ?? this.bgMid,
      bgSurface: bgSurface ?? this.bgSurface,
      bgHighlight: bgHighlight ?? this.bgHighlight,
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
      useOpaqueBackground: useOpaqueBackground ?? this.useOpaqueBackground,
    );
  }

  @override
  SandblasterThemeData lerp(ThemeExtension<SandblasterThemeData>? other, double t) {
    if (other is! SandblasterThemeData) return this;
    return SandblasterThemeData(
      bgDeep: Color.lerp(bgDeep, other.bgDeep, t)!,
      bgMid: Color.lerp(bgMid, other.bgMid, t)!,
      bgSurface: Color.lerp(bgSurface, other.bgSurface, t)!,
      bgHighlight: Color.lerp(bgHighlight, other.bgHighlight, t)!,
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
      useOpaqueBackground: t < 0.5 ? useOpaqueBackground : other.useOpaqueBackground,
    );
  }

  // Pre-defined Themes
  static const dark = SandblasterThemeData(
    bgDeep: Color(0xFF050814),
    bgMid: Color(0xFF0A0F2E),
    bgSurface: Color(0xFF0D1240),
    bgHighlight: Color(0xFF0F1B4D), // Original dark blue gradient center
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
    bgDeep: Color(0xFFFFFFFF), // Pure white
    bgMid: Color(0xFFF1F5F9),
    bgSurface: Color(0xFFE2E8F0),
    bgHighlight: Color(0xFFF8FAFC), // Faint blueish white
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
    textPrimary: Color(0xFF0A0F1A), // Darker text for extreme contrast
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
    bgHighlight: Color(0xFF3B0008), // Ruby highlight
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
    bgDeep: Color(0xFFFAF6F0), // Super light caramel / cream
    bgMid: Color(0xFFF4EAD5),
    bgSurface: Color(0xFFE6D5B8),
    bgHighlight: Color(0xFFF8F0E5), // Soft off-white tone
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
    textPrimary: Color(0xFF2A1C15), // Darker brown for contrast
    textSecondary: Color(0xFF5A4435),
    textTertiary: Color(0xFF826B5C),
    accent: Color(0xFFD0B8A8),
    accentGlow: Color(0x40D0B8A8),
    accentViolet: Color(0xFFAB8A72),
    success: Color(0xFF6A994E),
    warning: Color(0xFFD4A373),
    error: Color(0xFFBC4749),
  );

  static const inky = SandblasterThemeData(
    bgDeep: Color(0xFFF4F1EA), // Thick, slightly textured paper off-white
    bgMid: Color(0xFFEAE5D9), // Slightly darker paper grain
    bgSurface: Color(0xFFE2DCCF), // Elevated paper
    bgHighlight: Color(0xFFF9F7F1), // Purest paper white highlight
    orbBlue: Color(0xFF1D3557), // Deep ink blue
    orbViolet: Color(0xFF452B4E), // Deep dark violet ink
    orbCyan: Color(0xFF2A5256), // Dark teal ink
    orbPink: Color(0xFF682D3D), // Burgundy/magenta ink
    orbEmerald: Color(0xFF2B4738), // Forest/emerald ink
    glassSurface: Color(0x2EEAE5D9), // Frosted paper-like glass
    glassElevated: Color(0x40F9F7F1), // Brighter frosted glass
    glassOverlay: Color(0x59FFFFFF),
    glassBorder: Color(0x33101820), // Subtle ink border for contrast
    glassHighlight: Color(0x80FFFFFF),
    glassShadow: Color(0x1A050B14), // Dark ink shadow
    textPrimary: Color(0xFF101820), // Deep blue-black ink
    textSecondary: Color(0xFF384554), // Faded ink
    textTertiary: Color(0xFF657585), // Washed ink
    accent: Color(0xFF1D3557), // Primary deep blue ink
    accentGlow: Color(0x331D3557),
    accentViolet: Color(0xFF452B4E),
    success: Color(0xFF2E5945), // Subdued ink green
    warning: Color(0xFF915E22), // Subdued ink yellow/brown
    error: Color(0xFF8A2B3D), // Subdued ink red
    useOpaqueBackground: true,
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
  static ThemeData get inkyTheme => _buildTheme(
        Brightness.light,
        SandblasterThemeData.inky,
        isSerifTitle: true,
      );

  static ThemeData _buildTheme(Brightness brightness, SandblasterThemeData ext, {bool isSerifTitle = false}) {
    final baseTextTheme = brightness == Brightness.dark
        ? ThemeData.dark().textTheme
        : ThemeData.light().textTheme;
    
    TextStyle titleFont(TextStyle style) {
      if (isSerifTitle) {
        return GoogleFonts.lora(textStyle: style);
      }
      return GoogleFonts.inter(textStyle: style);
    }

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
        displayLarge: titleFont(TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w700,
          color: ext.textPrimary,
          letterSpacing: -1.5,
        )),
        displayMedium: titleFont(TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          color: ext.textPrimary,
          letterSpacing: -1.0,
        )),
        headlineLarge: titleFont(TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: ext.textPrimary,
          letterSpacing: -0.5,
        )),
        headlineMedium: titleFont(TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: ext.textPrimary,
        )),
        titleLarge: titleFont(TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: ext.textPrimary,
        )),
        titleMedium: titleFont(TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: ext.textPrimary,
        )),
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
