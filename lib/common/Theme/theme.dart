import 'package:flutter/material.dart';
import 'package:movies/common/Theme/app_colors.dart';

abstract class AppTheme {
  static ThemeData appTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.blackColor,
      centerTitle: true,
    ),
    scaffoldBackgroundColor: AppColors.blackColor,
  );
}
