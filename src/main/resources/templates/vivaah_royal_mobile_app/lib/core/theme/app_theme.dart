import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Material 3 theme for Vivaah Royal.
///
/// Typography pairs **Playfair Display** (royal serif, headings) with
/// **Inter** (clean sans, body) — both loaded through the Flutter Favorite
/// `google_fonts` package.
abstract final class AppTheme {
  static ThemeData light() {
    const scheme = ColorScheme.light(
      primary: AppColors.crimson,
      onPrimary: Colors.white,
      primaryContainer: AppColors.crimsonContainer,
      onPrimaryContainer: AppColors.onCrimsonContainer,
      secondary: AppColors.gold,
      onSecondary: Color(0xFF3A2C00),
      secondaryContainer: AppColors.goldContainer,
      onSecondaryContainer: AppColors.onGoldContainer,
      tertiary: AppColors.royalBlue,
      onTertiary: Colors.white,
      tertiaryContainer: AppColors.royalBlueContainer,
      onTertiaryContainer: Color(0xFF10264F),
      error: Color(0xFFB3261E),
      onError: Colors.white,
      surface: AppColors.surface,
      onSurface: AppColors.ink,
      onSurfaceVariant: AppColors.muted,
      outline: AppColors.outline,
      outlineVariant: AppColors.outline,
    );

    final base = ThemeData(useMaterial3: true, colorScheme: scheme);

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.ivory,
      textTheme: _royalTextTheme(base.textTheme),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.ivory,
        surfaceTintColor: Colors.transparent,
        foregroundColor: AppColors.ink,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.playfairDisplay(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.ink,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: AppColors.outline),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: _border(),
        enabledBorder: _border(),
        focusedBorder: _border(color: AppColors.crimson, width: 1.6),
        errorBorder: _border(color: scheme.error),
        focusedErrorBorder: _border(color: scheme.error, width: 1.6),
        labelStyle: const TextStyle(color: AppColors.muted),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.crimson,
          foregroundColor: Colors.white,
          minimumSize: const Size(64, 52),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.crimson,
          minimumSize: const Size(64, 52),
          side: const BorderSide(color: AppColors.crimson),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.crimson,
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: AppColors.surface,
        selectedColor: AppColors.goldContainer,
        side: const BorderSide(color: AppColors.outline),
        labelStyle: const TextStyle(color: AppColors.ink),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.goldContainer,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        labelTextStyle: WidgetStatePropertyAll(
          GoogleFonts.interTextTheme().bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.ink,
              ),
        ),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? AppColors.crimson : AppColors.muted,
            size: 26,
          );
        }),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.ink,
        contentTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      dividerTheme: const DividerThemeData(color: AppColors.outline),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.crimson,
        linearTrackColor: AppColors.outline,
      ),
      sliderTheme: const SliderThemeData(
        activeTrackColor: AppColors.crimson,
        inactiveTrackColor: AppColors.outline,
        thumbColor: AppColors.crimson,
        overlayColor: Color(0x148F1D22),
        valueIndicatorColor: AppColors.crimsonDark,
      ),
    );
  }

  static OutlineInputBorder _border({
    Color color = AppColors.outline,
    double width = 1,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  /// Builds the full text theme directly from per-style font getters.
  ///
  /// `google_fonts` 9.x replaced its `*TextTheme` helpers with the
  /// `material_ui` package, so we compose styles explicitly instead —
  /// same visual result, zero coupling to that transitional API.
  static TextTheme _royalTextTheme(TextTheme base) {
    TextStyle serif(TextStyle? style) => GoogleFonts.playfairDisplay(
          textStyle: style,
          fontWeight: FontWeight.w700,
          color: AppColors.ink,
        );

    TextStyle sans(TextStyle? style, {FontWeight? weight}) =>
        GoogleFonts.inter(
          textStyle: style,
          fontWeight: weight,
        );

    return base.copyWith(
      displayLarge: serif(base.displayLarge),
      displayMedium: serif(base.displayMedium),
      displaySmall: serif(base.displaySmall),
      headlineLarge: serif(base.headlineLarge),
      headlineMedium: serif(base.headlineMedium),
      headlineSmall: serif(base.headlineSmall),
      titleLarge: serif(base.titleLarge),
      titleMedium: sans(base.titleMedium, weight: FontWeight.w600),
      titleSmall: sans(base.titleSmall, weight: FontWeight.w600),
      bodyLarge: sans(base.bodyLarge),
      bodyMedium: sans(base.bodyMedium),
      bodySmall: sans(base.bodySmall),
      labelLarge: sans(base.labelLarge),
      labelMedium: sans(base.labelMedium),
      labelSmall: sans(base.labelSmall),
    );
  }
}
