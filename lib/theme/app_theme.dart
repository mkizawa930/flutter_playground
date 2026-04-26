import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final scheme = ColorScheme(
      brightness: brightness,
      primary: isDark ? Colors.white : Colors.black,
      onPrimary: isDark ? Colors.black : Colors.white,
      secondary: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
      onSecondary: isDark ? Colors.black : Colors.white,
      surface: isDark ? Colors.grey.shade900 : Colors.white,
      onSurface: isDark ? Colors.grey.shade100 : Colors.grey.shade900,
      surfaceContainerHighest:
          isDark ? Colors.grey.shade800 : Colors.grey.shade200,
      outline: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
      error: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
      onError: isDark ? Colors.black : Colors.white,
    );
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        centerTitle: false,
      ),
      dividerColor: scheme.outline,
    );
  }
}
