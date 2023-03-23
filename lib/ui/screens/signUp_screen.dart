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

  final TextEditingController _emailETController = TextEditingController();
  final TextEditingController _firstNameETController = TextEditingController();
  final TextEditingController _lastNameETController = TextEditingController();
  final TextEditingController _mobileETController = TextEditingController();
  final TextEditingController _passwordETController = TextEditingController();

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
                    controller: _emailETController,
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
                    controller: _firstNameETController,
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
                    controller: _lastNameETController,
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
                    controller: _mobileETController,
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
                    controller: _passwordETController,
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
                                  'email': _emailETController.text.trim(),
                                  'password': _passwordETController.text,
                                  'mobile': _mobileETController.text.trim(),
                                  'firstName':
                                      _firstNameETController.text.trim(),
                                  'lastName': _lastNameETController.text.trim(),
                                },
                              );
                              _inProgress = false;
                              setState(() {});
                              if (result != null &&
                                  result['status'] == 'success') {
                                _emailETController.clear();
                                _passwordETController.clear();
                                _mobileETController.clear();
                                _firstNameETController.clear();
                                _lastNameETController.clear();
                                if (mounted) {
                                  showSnackBarMessage(
                                      context, 'Registration Successful!');
                                }
                              } else {
                                if (mounted) {
                                  showSnackBarMessage(context,
                                      'Registration Failed, Try again', true);
                                }
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
