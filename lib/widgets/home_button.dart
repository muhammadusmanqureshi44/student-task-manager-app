import 'package:flutter/material.dart';
import 'package:student_task_manager_app/core/theme/app_text_styles.dart';

class HomeButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const HomeButton({
    super.key,
    required this.title,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
         fixedSize: Size(
          size.width > 600 ? size.width * 0.4 : size.width * 0.6,
          size.width > 600 ? size.width * 0.06 : size.width * 0.12,
         ),
        padding: EdgeInsets.symmetric(
          horizontal: size.width > 600 ? size.width * 0.10 : size.width * 0.18,
          vertical: size.width > 600 ? size.width * 0.015 : size.width * 0.025,
        ),
      ),
        child: Text(
          title,
          style: AppTextStyles.homeButtonText,
        ),
    );
  }
}
