import 'package:flutter/material.dart';
import 'package:task_manager_rest_api/ui/screens/signUp_screen.dart';
import 'package:task_manager_rest_api/ui/screens/verify_with_email_screen.dart';
import 'package:task_manager_rest_api/ui/utils/text_style.dart';
import 'package:task_manager_rest_api/ui/widgets/screen_background_widget.dart';

import '../widgets/app_elevated_button.dart';
import '../widgets/app_text_button.dart';
import '../widgets/app_text_field_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenBackground(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Get started with',
                    style: screenTitleTextStyle,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  AppTextFieldWidget(
                      hintText: 'Email', controller: TextEditingController()),
                  const SizedBox(height: 8),
                  AppTextFieldWidget(
                      hintText: 'Password',
                      controller: TextEditingController()),
                  const SizedBox(height: 8),
                  AppElevatedButton(
                    onTap: () {},
                    child: const Icon(Icons.arrow_circle_right_rounded),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => const VerifyWithEmailScreen(),));
                        },
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(color: Colors.grey),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      AppTextButton(onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ));
                      },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.green),
                        ),),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}


