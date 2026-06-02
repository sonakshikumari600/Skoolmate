import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF1A56DB);
  static const primaryDark = Color(0xFF1240A8);
  static const primaryLight = Color(0xFF4A90E2);
  static const background = Color(0xFFEFF6FF);
  static const cardWhite = Colors.white;
  static const textDark = Color(0xFF1E293B);
  static const textMuted = Color(0xFF64748B);
  static const inputFill = Color(0xFFF1F5F9);

  static const gradientPrimary = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const gradientBackground = LinearGradient(
    colors: [Color(0xFFDBEAFE), Color(0xFFEFF6FF), Color(0xFFFFFFFF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

class AppTextStyles {
  static const appName = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: AppColors.primary,
    letterSpacing: 1.0,
  );

  static const cardTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );

  static const body = TextStyle(
    fontSize: 14,
    color: AppColors.textMuted,
  );
}
