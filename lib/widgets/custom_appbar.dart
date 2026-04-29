import 'package:flutter/material.dart';
import 'package:student_task_manager_app/core/theme/app_text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final List<Widget>? actions;
  const CustomAppBar({
    super.key,
    required this.title,
    this.actions
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title,style: AppTextStyles.appBarTitle(context)),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
