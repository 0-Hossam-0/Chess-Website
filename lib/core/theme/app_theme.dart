import 'package:chess_app/core/theme/app_text_colors.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_sizes.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.bgMain,

      colorScheme: const ColorScheme.dark(
        surface: AppColors.panelBg,
        primary: AppColors.accent,
        secondary: AppColors.accentHover,
        error: AppColors.accentDanger,
        onSurface: AppTextColors.textPrimary,
        onPrimary: AppTextColors.textSecondary,
      ),

      cardTheme: const CardThemeData(
        color: AppColors.panelBg,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.panelBorder,
        thickness: 3,
      ),

      appBarTheme: const AppBarTheme(
        // toolbarHeight: AppSizes.headerHeight,
        backgroundColor: AppColors.panelBg,
        elevation: 0,
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.panelBg,
        selectedItemColor: AppColors.accent,
        unselectedItemColor: AppTextColors.textMuted,
        elevation: 0,
      ),
    );
  }
}
