import 'package:flutter/material.dart';
import 'app_colors.dart';
class AppTextStyles{
  AppTextStyles._();

  // Buttons
  static const primaryButtonText = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 17,
    color: AppColors.black,
  );
  static const homeButtonText = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppColors.black,
  );

  // AppBar Heading
  static TextStyle appBarTitle(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
        fontSize: size.width > 600 ? 35 : 22
    );
  }

  // Alert Dialog
  static const alertTitle = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.white,
    fontSize: 20
  );
  static const alertContent = TextStyle(
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    fontSize: 15
  );
  static const alertCancelButton = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );
  static const alertLogoutButton = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );
  static const alertEditButton = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  // Snack Bar
  static const successText = TextStyle(
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );
  static const errorText = TextStyle(
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );
  static const deletedText = TextStyle(
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );

  // List Tile
  static const taskTitle = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.white,
    fontSize: 18,
  );
  static const taskDescription = TextStyle(
    color: AppColors.grey,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  static const taskDateTime = TextStyle(
    color: AppColors.primary,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  static const emptyData = TextStyle(
    color: AppColors.primary,
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );
}