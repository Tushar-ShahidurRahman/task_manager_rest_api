import 'package:flutter/material.dart';
import 'package:task_manager_rest_api/ui/utils/text_style.dart';
import 'package:task_manager_rest_api/ui/widgets/app_elevated_button.dart';
import 'package:task_manager_rest_api/ui/widgets/app_text_button.dart';
import 'package:task_manager_rest_api/ui/widgets/app_text_field_widget.dart';
import 'package:task_manager_rest_api/ui/widgets/screen_background_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Text('Join With Us', style: screenTitleTextStyle),
                const SizedBox(height: 25),
                AppTextFieldWidget(
                    hintText: 'Email', controller: TextEditingController()),
                const SizedBox(height: 10),
                AppTextFieldWidget(
                    hintText: 'First Name',
                    controller: TextEditingController()),
                const SizedBox(height: 10),
                AppTextFieldWidget(
                    hintText: 'Last Name', controller: TextEditingController()),
                const SizedBox(height: 10),
                    AppTextFieldWidget(
                    hintText: 'Mobile', controller: TextEditingController()),
                const SizedBox(height: 10),
                AppTextFieldWidget(
                    hintText: 'Password', controller: TextEditingController()),
                const SizedBox(height: 10),
                AppElevatedButton(
                    child: const Icon(Icons.arrow_circle_right_rounded),
                    onTap: () {}),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text('Have an account?'),
                  AppTextButton(
                    child: const Text(
                      'Sign In',
                      style: TextStyle(color: Colors.green),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ])
              ],
            ),
          ),
        ),
      )),
    );
  }
}
