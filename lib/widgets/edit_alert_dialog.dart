import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:student_task_manager_app/core/theme/app_colors.dart';
import 'package:student_task_manager_app/core/theme/app_text_styles.dart';
import 'package:student_task_manager_app/core/utils/app_snackbar.dart';
import 'package:student_task_manager_app/widgets/custom_text_field.dart';

class EditAlertDialog extends StatefulWidget {
  final String currentTitle;
  final String currentDescription;
  final Function(String newTitle, String newDesc) onEdit;

  const EditAlertDialog({
    super.key,
    required this.currentTitle,
    required this.currentDescription,
    required this.onEdit
  });

  @override
  State<EditAlertDialog> createState() => _EditAlertDialogState();
}

class _EditAlertDialogState extends State<EditAlertDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController newTitleController;
  late TextEditingController newDescController;

  @override
  void initState(){
    super.initState();
    newTitleController = TextEditingController(text: widget.currentTitle);
    newDescController = TextEditingController(text: widget.currentDescription);
  }

  @override
  void dispose(){
    newTitleController.dispose();
    newDescController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return AlertDialog(
      scrollable: true,
      insetPadding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 24,
        right: 24,
        top: 24,
      ),
      backgroundColor: AppColors.scaffoldBackground,
      title: Text("Edit Task",style: AppTextStyles.alertTitle),
      content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                  controller: newTitleController,
                  hint: "Enter your title",
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Title is required"),
                  ]).call,
                  style: AppTextStyles.taskTitle,
              ),
              const SizedBox(height: 14),
              CustomTextField(
                controller: newDescController,
                hint: "Enter your description",
                validator: MultiValidator([
                  RequiredValidator(errorText: "Description is required"),
                ]).call,
                style: AppTextStyles.taskDescription,
              )
            ],
          )
      ),
      actions: [
        TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text("Cancel",style: AppTextStyles.alertCancelButton)
        ),
        ElevatedButton(
            onPressed: (){
              if(!_formKey.currentState!.validate()) return;
              widget.onEdit(newTitleController.text,newDescController.text);
              AppSnackBar.success(context, "Task edited successfully");
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              minimumSize: Size(70, 30),
              padding: EdgeInsetsGeometry.symmetric(vertical: 2,horizontal: 7),
            ),
            child: Text("Edit",style: AppTextStyles.alertEditButton)
        )
      ],
    );
  }
}
