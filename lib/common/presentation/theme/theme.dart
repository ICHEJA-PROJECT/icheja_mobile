import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';

class CustomTheme {
  static ThemeData get themeData => ThemeData(
        primaryColor: ColorTheme.primary,
        secondaryHeaderColor: ColorTheme.secondary,
        scaffoldBackgroundColor: ColorTheme.background,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: ColorTheme.text, fontFamily: 'Poppins'),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
}
