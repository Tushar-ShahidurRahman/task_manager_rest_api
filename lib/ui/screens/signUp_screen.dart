import 'package:flutter/material.dart';
import 'package:task_manager_rest_api/data/network_utils.dart';
import 'package:task_manager_rest_api/ui/utils/snackbar_message.dart';
import 'package:task_manager_rest_api/ui/utils/text_style.dart';
import 'package:task_manager_rest_api/ui/widgets/app_elevated_button.dart';
import 'package:task_manager_rest_api/ui/widgets/app_text_button.dart';
import 'package:task_manager_rest_api/ui/widgets/app_text_field_widget.dart';
import 'package:task_manager_rest_api/ui/widgets/screen_background_widget.dart';

import '../../data/urls.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _inProgress = false;

  final TextEditingController emailETController = TextEditingController();
  final TextEditingController firstNameETController = TextEditingController();
  final TextEditingController lastNameETController = TextEditingController();
  final TextEditingController mobileETController = TextEditingController();
  final TextEditingController passwordETController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Text('Join With Us', style: screenTitleTextStyle),
                  const SizedBox(height: 25),
                  AppTextFieldWidget(
                    hintText: 'Email',
                    controller: emailETController,
                    validator: (value) {
                      // if (value != null && value.isEmpty)
                      if (value?.isEmpty ?? true) {
                        return 'A valid Email must be given';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  AppTextFieldWidget(
                    hintText: 'First Name',
                    controller: firstNameETController,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter your First Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  AppTextFieldWidget(
                    hintText: 'Last Name',
                    controller: lastNameETController,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter your Last Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  AppTextFieldWidget(
                    hintText: 'Mobile',
                    controller: mobileETController,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter your mobile number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  AppTextFieldWidget(
                    hintText: 'Password',
                    controller: passwordETController,
                    validator: (value) {
                      if ((value?.isEmpty ?? true) &&
                          ((value?.length ?? 0) < 6)) {
                        return 'Enter a password with 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  _inProgress
                      ? const Center(
                        child: CircularProgressIndicator(
                            color: Colors.green,
                          ),
                      )
                      : AppElevatedButton(
                          child: const Icon(Icons.arrow_circle_right_rounded),
                          onTap: () async {
                            if (_formkey.currentState!.validate()) {
                              _inProgress = true;
                              setState(() {});

                              final result = await NetworkUtils.postMethod(
                                Urls.registrationUrl,
                                body: {
                                  'email': emailETController.text.trim(),
                                  'password': passwordETController.text,
                                  'mobile': mobileETController.text.trim(),
                                  'firstName':
                                      firstNameETController.text.trim(),
                                  'lastName': lastNameETController.text.trim(),
                                },
                              );
                              _inProgress = false;
                              setState(() {});
                              if (result != null &&
                                  result['status'] == 'success') {
                                emailETController.clear();
                                passwordETController.clear();
                                mobileETController.clear();
                                firstNameETController.clear();
                                lastNameETController.clear();
                                showSnackBarMessage(
                                    context, 'Registration Successful!');
                              } else {
                                showSnackBarMessage(context,
                                    'Registration Failed, Try again', true);
                              }
                            }
                          }),
                  const SizedBox(
                    height: 16,
                  ),
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
        ),
      )),
    );
  }
}
