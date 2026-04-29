import 'package:flutter/material.dart';
import 'package:student_task_manager_app/core/theme/app_colors.dart';
import 'package:student_task_manager_app/core/theme/app_text_styles.dart';

class AppTheme{
  AppTheme._();

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.scaffoldBackground,

    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
    ),

    snackBarTheme: SnackBarThemeData(
      actionTextColor: AppColors.primary,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.black,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.primary),
    ),

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.primary,
      selectionColor: AppColors.primary,
      selectionHandleColor: AppColors.primary,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.inputFill,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.inputBorder,),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.error),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.error,width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      errorStyle: TextStyle(color: AppColors.error),
      labelStyle: TextStyle(color: AppColors.primary),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),

    iconTheme: IconThemeData(
      color: AppColors.primary,
    ),
  );
}