import 'package:flutter/material.dart';
import 'package:student_task_manager_app/core/theme/app_colors.dart';
import 'package:student_task_manager_app/core/theme/app_text_styles.dart';

class AppSnackBar {
  AppSnackBar._();

  static void success(BuildContext context, String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: AppColors.white, size: 22),
            const SizedBox(width: 10),
            Text(message, style: AppTextStyles.successText),
          ],
          ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(horizontal: 16),
        duration: Duration(seconds: 3),
      )
    );
  }

  static void error(BuildContext context, String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
        Row(
          children: [
            Icon(Icons.error,color: AppColors.white,size: 22),
            SizedBox(width: 10),
            Text(
              message,
              style: AppTextStyles.errorText,
            ),
          ],
        ),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(horizontal: 16),
        duration: Duration(seconds: 3),
      ),
    );
  }

  static void deleted(BuildContext context, VoidCallback onUndo){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.delete,color: AppColors.white,size: 22,),
              const SizedBox(width: 10),
              Text("Task deleted",
                style: AppTextStyles.deletedText
              ),
            ],
          ),
          action: SnackBarAction(
              label: "UNDO",
              textColor: AppColors.primary,
              onPressed: onUndo
          ),
          backgroundColor: AppColors.danger,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(16),
          duration: Duration(seconds: 3),
        )
    );
  }
}