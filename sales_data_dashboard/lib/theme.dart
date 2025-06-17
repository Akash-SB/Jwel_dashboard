import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFFF7F9FC);
  static const card = Colors.white;
  static const primary = Color(0xFF3F8CFF);
  static const accent = Color(0xFFFFD700);
  static const text = Color(0xFF1A1A1A);
  static const success = Color(0xFF28C76F);
  static const danger = Color(0xFFFF4D4F);
  static const grey = Color(0xFFB0B3B8);
}

final appTheme = ThemeData(
  fontFamily: 'Inter',
  scaffoldBackgroundColor: AppColors.background,
  dividerColor: Colors.grey.shade300,
  dataTableTheme: const DataTableThemeData(
    dividerThickness: 0.8,
  ),
  colorScheme: const ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.accent,
  ),
);
