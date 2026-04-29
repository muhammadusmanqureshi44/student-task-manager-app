import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_task_manager_app/core/theme/app_colors.dart';
import 'package:student_task_manager_app/screens/home_screen.dart';
import 'package:student_task_manager_app/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    checkUserLogin();
  }
  Future<void> checkUserLogin()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');
    await Future.delayed(Duration(seconds: 2));
    if(token != null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
    }
    else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Image.asset(
                  "assets/app_logo/trans_app_logo.png",
                  width: size.width > 600
                  ? size.width * 0.45
                  : size.width * 0.95,
              ),
            ),
            SizedBox(height: size.height * 0.05),
            SizedBox(
                height: size.width > 600 ? 50 : 40,
                width: size.width > 600 ? 50 : 40,
                child: CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 3,
                )
            ),
          ],
        ),
      ),
    );
  }
}
