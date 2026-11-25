import 'package:flutter/material.dart';

class AppColors {
  // Greens
  static const Color primaryDarkGreen = Color(0xFF1B4332);
  static const Color primaryGreen = Color(0xFF2D6A4F);
  static const Color mediumGreen = Color(0xFF40916C);
  static const Color leafGreen = Color(0xFF52B788);
  static const Color lightMint = Color(0xFFD8F3DC);
  static const Color paleSage = Color(0xFFE8F5E9);

  // Soft Yellows
  static const Color softYellow = Color(0xFFFFF9DB);
  static const Color warmButterYellow = Color(0xFFFEF3C7);
  static const Color brightYellowAccent = Color(0xFFF6C845);
  static const Color yellowDark = Color(0xFFB45309);

  // Whites & Neutrals
  static const Color background = Color(0xFFF8FAF7);
  static const Color cardWhite = Colors.white;
  static const Color textDark = Color(0xFF192A22);
  static const Color textMuted = Color(0xFF5A6E64);
  static const Color dividerLight = Color(0xFFE5ECE7);

  // Device Frame
  static const Color desktopBackground = Color(0xFFE5E7EB);
  static const Color phoneFrameBezel = Color(0xFF111827);
  static const Color phoneFrameNotch = Color(0xFF000000);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryGreen,
        primary: AppColors.primaryGreen,
        secondary: AppColors.brightYellowAccent,
        surface: AppColors.background,
        surfaceContainerHighest: AppColors.lightMint,
      ),
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Segoe UI',
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColors.textDark,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
        iconTheme: IconThemeData(color: AppColors.textDark),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: AppColors.textMuted,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.dividerLight, width: 1.2),
        ),
      ),
    );
  }
}
