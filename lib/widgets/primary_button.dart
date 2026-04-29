import 'package:flutter/material.dart';
import 'package:student_task_manager_app/core/theme/app_colors.dart';
import 'package:student_task_manager_app/core/theme/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final String title;

  const PrimaryButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return isLoading
        ? const Center(child: CircularProgressIndicator(color: AppColors.primary,))
        : SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03,
              vertical: size.width > 600
              ? size.width * 0.017
              : size.width * 0.035
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.primaryButtonText,
        ),
      ),
    );
  }
}