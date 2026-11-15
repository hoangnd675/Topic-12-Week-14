import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color _brand = Color(0xFF635BFF);
  static const Color _background = Color(0xFFF5F6FA);
  static const Color _darkBackground = Color(0xFF10131C);

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _brand,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: _background,
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _brand,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: _darkBackground,
      );
}
