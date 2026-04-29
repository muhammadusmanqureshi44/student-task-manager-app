import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_task_manager_app/core/utils/app_snackbar.dart';
import 'package:student_task_manager_app/screens/home_screen.dart';
import 'package:student_task_manager_app/widgets/custom_text_field.dart';
import 'package:student_task_manager_app/widgets/primary_button.dart';
import 'package:student_task_manager_app/widgets/password_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  bool _isLoading = false;
  bool obscureText = true;

  Future<void> loginUser()async{
    if(!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
    });
    final response = await http.post(
    Uri.parse("https://dummyjson.com/auth/login"),
    headers: {'Content-Type': "application/json"},
    body: jsonEncode({
      'username' : usernameController.text.trim(),
      'password' : passController.text.trim(),
    }),
   );
   debugPrint("Status Code: ${response.statusCode}");
   debugPrint("Response Body: ${response.body}");
   setState(() {
    _isLoading = false;
   });
    final data = jsonDecode(response.body);
    if(response.statusCode == 200){
    final token = data['accessToken'];
    debugPrint("Access Token $token");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_)=> HomeScreen()),
    );
    }else {
    final error = jsonDecode(response.body);
    AppSnackBar.error(context, error['message'] ?? 'Login failed');
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Center(
              child: Form(
                key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width > 600
                      ? size.width * 0.2
                      : size.width * 0.06,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextField(
                            controller: usernameController,
                            hint: "Enter your username",
                            prefixIcon: const Icon(Icons.person_outline),
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Username is required"),
                            ]).call
                        ),
                        SizedBox(height: size.height * 0.025),
                        PasswordField(
                            controller: passController,
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Password is required"),
                              MinLengthValidator(8, errorText: "Password must be at least 8 characters"),
                            ]).call
                        ),
                        SizedBox(height: size.height * 0.05),
                        PrimaryButton(
                            isLoading: _isLoading,
                            onPressed: loginUser,
                            title: "Login"
                        )
                      ],
                    ),
                  )
              )
          )
      ),
    );
  }
}




