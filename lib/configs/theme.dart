import 'package:flutter/material.dart';
import 'package:ropstem_task/utils/color.dart';


class AppTheme {
  ///Default font
  static const String defaultFont = "ProximaNova";
  ///Get theme data
  static ThemeData getTheme({
    // required ThemeModel theme,
    required Brightness brightness,
    String? font,
  }) {
    ColorScheme? colorScheme;
    switch (brightness) {
      case Brightness.light:
        colorScheme = ColorScheme.light(
          primary: UtilColor.getColorFromHex('#ffe5634d'),
          secondary: UtilColor.getColorFromHex('#ff4a91a4'),
        );
        break;
      default:
    }

    final isDark = colorScheme!.brightness == Brightness.dark;
    final indicatorColor = isDark ? colorScheme.onSurface : colorScheme.primary;

    return ThemeData(
      brightness: colorScheme.brightness,
      primaryColor: colorScheme.primary,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: isDark ? Colors.white : Colors.black,
        shadowColor: isDark ? null : colorScheme.onSurface.withOpacity(0.2),
      ),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      bottomAppBarColor: colorScheme.surface,
      cardColor: colorScheme.surface,
      dividerColor: colorScheme.onSurface.withOpacity(0.12),
      backgroundColor: colorScheme.background,
      dialogBackgroundColor: colorScheme.background,
      errorColor: colorScheme.error,
      indicatorColor: indicatorColor,
      applyElevationOverlayColor: isDark,
      colorScheme: colorScheme,

      ///Custom
      fontFamily: font,
      dialogTheme: DialogTheme(
        backgroundColor: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        shape: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(
        thickness: 0.8,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        shape: CircularNotchedRectangle(),
      ),
    );
  }
  ///Singleton factory
  static final AppTheme _instance = AppTheme._internal();

  factory AppTheme() {
    return _instance;
  }

  AppTheme._internal();
}
