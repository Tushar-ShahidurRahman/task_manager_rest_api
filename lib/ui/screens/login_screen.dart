import 'package:flutter/material.dart';
import 'package:task_manager_rest_api/data/auth_utils.dart';
import 'package:task_manager_rest_api/data/network_utils.dart';
import 'package:task_manager_rest_api/ui/screens/main_bottom_nav_bar.dart';
import 'package:task_manager_rest_api/ui/screens/signUp_screen.dart';
import 'package:task_manager_rest_api/ui/screens/verify_with_email_screen.dart';
import 'package:task_manager_rest_api/ui/utils/snackbar_message.dart';
import 'package:task_manager_rest_api/ui/utils/text_style.dart';
import 'package:task_manager_rest_api/ui/widgets/screen_background_widget.dart';

import '../../data/urls.dart';
import '../widgets/app_elevated_button.dart';
import '../widgets/app_text_button.dart';
import '../widgets/app_text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailETController = TextEditingController();
  final TextEditingController _passwordETController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _inProgress = false;

  Future<void> login() async {
    _inProgress = true;
    setState(() {});
    final result = await NetworkUtils.postMethod(
      Urls.loginUrl,
      body: {
        'email': _emailETController.text.trim(),
        'password': _passwordETController.text,
      },
      onUnAuthorized: () {
        showSnackBarMessage(
            context, 'User name or password is incorrect', true);
      },
    );
    _inProgress = false;
    setState(() {});

    if (result != null && result['status'] == 'success') {
      //from the inside of that login method call AuthUtils.saveUser method.
      AuthUtils.saveUserData(
        userEmail: result['data']['email'],
        userFirstName: result['data']['firstName'],
        userLastName: result['data']['lastName'],
        userProfilePic: result['data']['photo'],
        userMobile: result['data']['mobile'],
        userToken: result['token'],
      );

      // _emailETController.clear();
      // _passwordETController.clear();

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const MainBottomNavBar(),
          ),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenBackground(
            child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
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
                    hintText: 'Email',
                    controller: _emailETController,
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter a valid Email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  AppTextFieldWidget(
                    hintText: 'Password',
                    controller: _passwordETController,
                    validator: (String? value) {
                      if ((value?.isEmpty ?? true) &&
                          ((value?.length ?? 0) < 6)) {
                        return 'Enter a password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  if (_inProgress)
                    const Center(child: CircularProgressIndicator(color: Colors.green))
                  else
                    AppElevatedButton(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          //call the log in method from here.
                          login();
                        }
                      },
                      child: const Icon(Icons.arrow_circle_right_rounded),
                    ),
                  const SizedBox(height: 30),
                  Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const VerifyWithEmailScreen(),
                              ));
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
                      AppTextButton(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ));
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
