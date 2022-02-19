import 'package:flutter/material.dart';
import 'package:freshflow_test/app/resources/colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData createTheme() {
    final baseTheme = ThemeData.from(
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary900,
        primaryVariant: AppColors.primary700,
        onBackground: AppColors.background,
        error: AppColors.negative700,
        secondary: AppColors.secondary700,
        secondaryVariant: AppColors.secondary300,
      ),
    );

    return baseTheme.copyWith(
      textTheme: _createTextTheme(baseTheme.textTheme),
    );
  }

  static TextTheme _createTextTheme(TextTheme baseTextTheme) =>
      baseTextTheme.copyWith(

        headline3: baseTextTheme.headline3?.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
        ),


        headline4: baseTextTheme.headline4?.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
        ),

        subtitle1: baseTextTheme.subtitle1?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 22.0 / 16.0,
          fontStyle: FontStyle.normal,
        ),

        bodyText1: baseTextTheme.bodyText1?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),


        caption: baseTextTheme.caption?.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 18.0 / 14.0,
          fontStyle: FontStyle.normal,
        ),

        overline: baseTextTheme.overline?.copyWith(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            color: AppColors.neutral700),
      );
}
