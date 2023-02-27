import 'package:flutter/material.dart';
import 'package:task_manager_rest_api/ui/utils/text_style.dart';
import 'package:task_manager_rest_api/ui/widgets/app_elevated_button.dart';
import 'package:task_manager_rest_api/ui/widgets/app_text_button.dart';
import 'package:task_manager_rest_api/ui/widgets/app_text_field_widget.dart';
import 'package:task_manager_rest_api/ui/widgets/screen_background_widget.dart';

class VerifyWithEmailScreen extends StatefulWidget {
  const VerifyWithEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyWithEmailScreen> createState() => _VerifyWithEmailScreenState();
}

class _VerifyWithEmailScreenState extends State<VerifyWithEmailScreen> {
  @override
  Widget build(BuildContext context) {
    const String pageText =
        'A 6 digit verification pin will send to your email address';
    return Scaffold(
      body: ScreenBackground(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your Email Address', style: screenTitleTextStyle),
              const SizedBox(height: 15),
              Text(pageText, style: screenSubtitleTextStyle),
              const SizedBox(height: 15),
              AppTextFieldWidget(
                  hintText: 'Email', controller: TextEditingController()),
              const SizedBox(height: 15),
              AppElevatedButton(
                  child: const Icon(Icons.arrow_circle_right_rounded),
                  onTap: () {}),
              const SizedBox(height: 15),
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
                        Navigator.pop(context);
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
