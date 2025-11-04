import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BrandColors {
  // LIGHT
  static const primary      = Color(0xFF6043F3);
  static const onPrimary    = Color(0xFFFFFFFF);
  static const primaryCtr   = Color(0xFFB3E7FA);
  static const onPrimaryCtr = Color(0xFF003244);

  static const secondary      = Color(0xFF836AFF);
  static const onSecondary    = Colors.white;
  static const secondaryCtr   = Color(0xFFB5ECEF);
  static const onSecondaryCtr = Color(0xFF002125);

  static const tertiary      = Color(0xFFFDA9C1);
  static const onTertiary    = Colors.white;
  static const tertiaryCtr   = Color(0xFFE2DAFF);
  static const onTertiaryCtr = Color(0xFF251A66);

  static const surface       = Color(0xFFF5F3FE);
  static const onSurface     = Color(0xFF232323);
  static const surfaceVar    = Color(0xFFE8ECF1);
  static const onSurfaceVar  = Color(0xFF6B7280);

  static const outline       = Color(0xFFCBD5E1);
  static const outlineVar    = Color(0xFFA8B1BD);

  static const error         = Color(0xFFD22222);
  static const onError       = Colors.white;
  static const errorCtr      = Color(0xFFFFE1E1);
  static const onErrorCtr    = Color(0xFF5E1111);

  static const inverseSurface = Color(0xFF111317);
  static const inversePrimary = Color(0xFF69D5FF);

  // DARK
  static const dPrimary      = Color(0xFF4CC9F0);
  static const dOnPrimary    = Color(0xFF00212C);
  static const dPrimaryCtr   = Color(0xFF004C61);
  static const dOnPrimaryCtr = Colors.white;

  static const dSecondary      = Color(0xFF71D0D6);
  static const dOnSecondary    = Color(0xFF002A2E);
  static const dSecondaryCtr   = Color(0xFF0E4E54);
  static const dOnSecondaryCtr = Colors.white;

  static const dTertiary      = Color(0xFFB6A6FF);
  static const dOnTertiary    = Color(0xFF231957);
  static const dTertiaryCtr   = Color(0xFF372E87);
  static const dOnTertiaryCtr = Colors.white;

  static const dSurface      = Color(0xFF0F1115);
  static const dOnSurface    = Color(0xFFE5E7EB);
  static const dSurfaceVar   = Color(0xFF1A1F25);
  static const dOnSurfaceVar = Color(0xFF9CA3AF);

  static const dOutline      = Color(0xFF2A3139);
  static const dOutlineVar   = Color(0xFF3B4350);

  static const dError        = Color(0xFFFF7A7A);
  static const dOnError      = Color(0xFF3C0C0C);
  static const dErrorCtr     = Color(0xFF5C1F1F);
  static const dOnErrorCtr   = Color(0xFFFFD6D6);

  static const dInverseSurface = Color(0xFFEFF2F6);
  static const dInversePrimary = Color(0xFF0098CF);
}

final ColorScheme lightScheme = const ColorScheme.light().copyWith(
  primary: BrandColors.primary,
  onPrimary: BrandColors.onPrimary,
  primaryContainer: BrandColors.primaryCtr,
  onPrimaryContainer: BrandColors.onPrimaryCtr,
  secondary: BrandColors.secondary,
  onSecondary: BrandColors.onSecondary,
  secondaryContainer: BrandColors.secondaryCtr,
  onSecondaryContainer: BrandColors.onSecondaryCtr,
  tertiary: BrandColors.tertiary,
  onTertiary: BrandColors.onTertiary,
  tertiaryContainer: BrandColors.tertiaryCtr,
  onTertiaryContainer: BrandColors.onTertiaryCtr,
  surface: BrandColors.surface,
  onSurface: BrandColors.onSurface,
  surfaceContainerHighest: BrandColors.surfaceVar,
  onSurfaceVariant: BrandColors.onSurfaceVar,
  outline: BrandColors.outline,
  outlineVariant: BrandColors.outlineVar,
  error: BrandColors.error,
  onError: BrandColors.onError,
  errorContainer: BrandColors.errorCtr,
  onErrorContainer: BrandColors.onErrorCtr,
  inverseSurface: BrandColors.inverseSurface,
  inversePrimary: BrandColors.inversePrimary,
);

final ColorScheme darkScheme = const ColorScheme.dark().copyWith(
  primary: BrandColors.dPrimary,
  onPrimary: BrandColors.dOnPrimary,
  primaryContainer: BrandColors.dPrimaryCtr,
  onPrimaryContainer: BrandColors.dOnPrimaryCtr,
  secondary: BrandColors.dSecondary,
  onSecondary: BrandColors.dOnSecondary,
  secondaryContainer: BrandColors.dSecondaryCtr,
  onSecondaryContainer: BrandColors.dOnSecondaryCtr,
  tertiary: BrandColors.dTertiary,
  onTertiary: BrandColors.dOnTertiary,
  tertiaryContainer: BrandColors.dTertiaryCtr,
  onTertiaryContainer: BrandColors.dOnTertiaryCtr,
  surface: BrandColors.dSurface,
  onSurface: BrandColors.dOnSurface,
  surfaceContainerHighest: BrandColors.dSurfaceVar,
  onSurfaceVariant: BrandColors.dOnSurfaceVar,
  outline: BrandColors.dOutline,
  outlineVariant: BrandColors.dOutlineVar,
  error: BrandColors.dError,
  onError: BrandColors.dOnError,
  errorContainer: BrandColors.dErrorCtr,
  onErrorContainer: BrandColors.dOnErrorCtr,
  inverseSurface: BrandColors.dInverseSurface,
  inversePrimary: BrandColors.dInversePrimary,
);

class AppTheme {
  static ThemeData light = _build(lightScheme);
  static ThemeData dark  = _build(darkScheme);

  static ThemeData _build(ColorScheme scheme) {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
    return base.copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(base.textTheme).copyWith(
        titleLarge: GoogleFonts.poppins(fontWeight: FontWeight.w700),
        titleMedium: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        labelLarge: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        centerTitle: true,
      ),
      iconTheme: IconThemeData(color: scheme.onSurface),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(scheme.primary),
          foregroundColor: WidgetStatePropertyAll(scheme.onPrimary),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          ),
          textStyle: WidgetStatePropertyAll(
            GoogleFonts.poppins(fontWeight: FontWeight.w700),
          ),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: scheme.surfaceContainerHighest,
        labelStyle: TextStyle(color: scheme.onSurfaceVariant),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: scheme.onSurface,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 14, fontWeight: FontWeight.w500, color: scheme.onSurface),
        subtitleTextStyle: GoogleFonts.poppins(
          fontSize: 12, color: scheme.onSurfaceVariant),
      ),
      dividerColor: scheme.outlineVariant,
      cardColor: scheme.surface,
    );
  }
}
