import 'package:flutter/material.dart';
import 'package:task_manager_rest_api/ui/utils/text_style.dart';
import 'package:task_manager_rest_api/ui/widgets/app_elevated_button.dart';
import 'package:task_manager_rest_api/ui/widgets/app_text_field_widget.dart';
import 'package:task_manager_rest_api/ui/widgets/screen_background_widget.dart';

import '../widgets/app_text_button.dart';
import 'login_screen.dart';

class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Set Password', style: screenTitleTextStyle),
              const SizedBox(height: 10),
              Text('Minimum length password 8 character with letter and number',
                  style: screenSubtitleTextStyle),
              const SizedBox(height: 10),
              AppTextFieldWidget(
                  hintText: 'Password', controller: TextEditingController()),
              const SizedBox(height: 10),
              AppTextFieldWidget(
                  hintText: 'Confirm Password',
                  controller: TextEditingController()),
              const SizedBox(height: 10),
              AppElevatedButton(child: const Text('Confirm'), onTap: () {}),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Have an account?'),
                  AppTextButton(
                      child: const Text(
                        'Sign In',
                        style: TextStyle(color: Colors.green),
                      ),
                      onTap: () {
                        // Here PushAndRemove until is used to navigate easily
                        // from pin verification page to log in page.
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                                (route) => false);
                      }),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
