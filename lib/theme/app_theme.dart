import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData {
  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: _textTheme,
      // Matches manifest.json colors and background color.
      primaryColor: colorScheme.primary,
      appBarTheme: AppBarTheme(
        foregroundColor: colorScheme.primary,
        backgroundColor: colorScheme.primaryContainer,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
      ),
      iconTheme: IconThemeData(color: colorScheme.primary),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          const Color(0xff212121),
          Colors.white,
        ),
        contentTextStyle: _textTheme.subtitle1?.apply(color: Colors.white),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: colorScheme.primary,
        backgroundColor: colorScheme.primaryContainer,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.onPrimary,
      ),
      tabBarTheme: TabBarTheme(
        labelColor: colorScheme.primary,
      ),
      indicatorColor: colorScheme.primary,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(72),
          ),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.primaryContainer,
        ),
      ),
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Colors.white,
    primaryContainer: Color(0xfffb7299),
    secondary: Color(0xffa0a0a0),
    secondaryContainer: Colors.white,
    background: Color(0xffeaeaea),
    surface: Color(0xffeaeaea),
    onBackground: Color(0xff212121),
    error: Color(0xff757575),
    onError: Color(0xff757575),
    onPrimary: Color(0xfffb7299),
    onSecondary: Color(0xfffb7299),
    onSurface: Colors.white,
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xfff5f5f5),
    primaryContainer: Color(0xff212a2f),
    secondary: Color(0xff999999),
    secondaryContainer: Color(0xff37474f),
    background: Color(0xff212121),
    surface: Color(0xff212121),
    onBackground: Color(0xff212121),
    // White with 0.05 opacity
    error: Color(0xfff5f5f5),
    onError: Color(0xfff5f5f5),
    onPrimary: Color(0xfff5f5f5),
    onSecondary: Color(0xfff5f5f5),
    onSurface: Colors.white,
    brightness: Brightness.dark,
  );

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static final TextTheme _textTheme = TextTheme(
    headlineMedium: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 20.0),
    bodySmall: GoogleFonts.oswald(fontWeight: _semiBold, fontSize: 16.0),
    headlineSmall: GoogleFonts.oswald(fontWeight: _medium, fontSize: 16.0),
    labelSmall: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 12.0),
    titleMedium: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 13.0),
    titleSmall: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 14.0),
    bodyLarge: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 12.0),
    bodyMedium: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 12.0),
    titleLarge: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 16.0),
    labelLarge: GoogleFonts.montserrat(fontWeight: _semiBold, fontSize: 14.0),
  );
}
