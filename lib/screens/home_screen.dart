import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_task_manager_app/core/theme/app_colors.dart';
import 'package:student_task_manager_app/screens/add_task_screen.dart';
import 'package:student_task_manager_app/screens/login_screen.dart';
import 'package:student_task_manager_app/screens/view_task_screen.dart';
import 'package:student_task_manager_app/widgets/custom_alert_dialog.dart';
import 'package:student_task_manager_app/widgets/custom_appbar.dart';
import 'package:student_task_manager_app/widgets/home_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> logoutUser()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_)=> LoginScreen()),
        (route) => false,
    );
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
          title: "Task Manager",
          actions: [
                IconButton(
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder: (_) => CustomAlertDialog(
                              title: "Logout?",
                              content: "Are you sure you want to logout?",
                              confirmText: "Logout",
                              onConfirm: logoutUser
                          )
                      );
                    },
                    icon: Icon(Icons.logout,color: AppColors.danger,size: size.width > 600 ? 27 : 24)
                ),
                const SizedBox(width: 10)
          ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: size.width > 600 ? size.height * 0.2 : size.height * 0.09),
            HomeButton(
                title: "Add Task",
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AddTaskScreen()));
                }
            ),
            SizedBox(height: size.width > 600 ? size.height * 0.09 : size.height * 0.03),
            HomeButton(
                title: "View Tasks",
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewTaskScreen()));
                }
            )
          ],
        ),
      ),
    );
  }
}
