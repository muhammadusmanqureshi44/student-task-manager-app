import 'package:flutter/material.dart';
import 'package:student_task_manager_app/core/theme/app_colors.dart';
import 'package:student_task_manager_app/core/theme/app_text_styles.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final VoidCallback onConfirm;
  final Color confirmColor;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.confirmText,
    required this.onConfirm,
    this.confirmColor = AppColors.danger,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.scaffoldBackground,
      title: Text(title,style: AppTextStyles.alertTitle),
      content: Text(content,style: AppTextStyles.alertContent),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel",style: AppTextStyles.alertCancelButton)
        ),
        ElevatedButton(
            onPressed: onConfirm,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.danger,
              minimumSize: Size(70, 30),
              padding: EdgeInsetsGeometry.symmetric(vertical: 2,horizontal: 7),
            ),
            child: Text(confirmText,style: AppTextStyles.alertLogoutButton)
        )
      ],
    );
  }
}
