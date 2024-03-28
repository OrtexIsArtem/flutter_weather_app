import 'package:flutter/material.dart';
import 'package:flutter_weather_app/core/constants/app_colors.dart';

final class AppTheme {
  const AppTheme._();

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      primaryColor: AppColors.primary,
      textTheme: TextTheme(
        bodyLarge: baseTextStyle.copyWith(
          fontSize: 34,
        ),
        bodyMedium: baseTextStyle,
        bodySmall: baseTextStyle.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.primaryIcon,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: AppTheme.border,
        suffixIconColor: AppColors.secondary,
        fillColor: AppColors.bgSecondary,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 11),
        hintStyle: TextStyle(
          fontFamily: 'SFCompact',
          fontSize: 17,
          color: AppColors.secondary.withOpacity(0.6),
        ),
      ),
    );
  }

  static const TextStyle baseTextStyle = TextStyle(
    fontSize: 20,
    color: AppColors.primary,
    fontFamily: 'SFProDisplay',
    fontWeight: FontWeight.w400,
  );

  static InputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      width: 0,
      style: BorderStyle.none,
    ),
  );

  static InputBorder focusedBorder = border.copyWith();

  static InputBorder enabledBorder = border.copyWith();
}
