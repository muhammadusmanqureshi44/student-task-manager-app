import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:student_task_manager_app/core/utils/app_snackbar.dart';
import 'package:student_task_manager_app/widgets/custom_appbar.dart';
import 'package:student_task_manager_app/widgets/custom_text_field.dart';
import 'package:student_task_manager_app/widgets/primary_button.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  bool isLoading = false;
  Future<void> addTask()async{
    if(!_formKey.currentState!.validate()) return;
    setState(() {
      isLoading = true;
    });

   await FirebaseFirestore.instance.collection('tasks').add({
      'taskTitle' : titleController.text,
      'taskDescription' : descriptionController.text,
      'createdAt' : Timestamp.now(),
   });
    setState(() {
      isLoading = false;
    });
    titleController.clear();
    descriptionController.clear();
    AppSnackBar.success(context, "Task added successfully");
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
          title: "Add Task"
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width > 600
                  ? size.width * 0.2
                  : size.width * 0.06,
              vertical: size.width > 600 ? size.width * 0.07 : size.width * 0.13,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomTextField(
                    controller: titleController,
                    hint: "Enter your title",
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Title is required"),
                    ]).call,
                ),
                SizedBox(height: size.width > 600 ? size.height * 0.060 : size.height * 0.025),
                CustomTextField(
                    controller: descriptionController,
                    hint: "Enter your description",
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Description is required"),
                    ]).call,
                ),
                SizedBox(height: size.width > 600 ? size.height * 0.1 : size.height * 0.06),
                PrimaryButton(
                    isLoading: isLoading,
                    onPressed: addTask,
                    title: "Add Task"
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
