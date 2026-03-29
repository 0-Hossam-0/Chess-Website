import 'package:flutter/material.dart';

abstract class AppColors {
  // Base Colors - Sleek Midnight Theme
  static const Color bgMain = Color(0xFF0F172A);
  static const Color panelBg = Color(0xFF1E293B);
  static const Color panelBgHover = Color(0xFF334155);
  static const Color panelBorder = Color(0x1AFFFFFF);

  // Accents
  static const Color accent = Color(0xFF3B82F6);
  static const Color accentHover = Color(0xFF60A5FA);
  static const Color accentGlow = Color(0x663B82F6);
  static const Color accentDanger = Color(0xFFEF4444);
  static const Color accentDangerHover = Color(0xFFF87171);

  // Board Defaults (Green)
  static const Color lightSq = Color(0xFFEBECD0);
  static const Color darkSq = Color(0xFF739552);

  // Highlighting with Opacity
  // Tip: 0.4 opacity in hex is approximately 66 (40% of 255)
  static const Color highlightSq = Color(0x66FFFF33);
  static const Color lastMoveSq = Color(0x699BC700);
}
