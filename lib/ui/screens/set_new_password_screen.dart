import 'package:flutter/material.dart';
import 'package:task_manager_rest_api/data/network_utils.dart';
import 'package:task_manager_rest_api/ui/utils/snackbar_message.dart';
import 'package:task_manager_rest_api/ui/utils/text_style.dart';
import 'package:task_manager_rest_api/ui/widgets/app_elevated_button.dart';
import 'package:task_manager_rest_api/ui/widgets/app_text_field_widget.dart';
import 'package:task_manager_rest_api/ui/widgets/screen_background_widget.dart';

import '../../data/urls.dart';
import '../widgets/app_text_button.dart';
import 'login_screen.dart';

class SetNewPasswordScreen extends StatefulWidget {
  final String email, otp;

  // final String otp;
  const SetNewPasswordScreen({Key? key, required this.email, required this.otp})
      : super(key: key);

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final TextEditingController _newResetPasswordETController =
      TextEditingController();
  final TextEditingController _confirmResetPasswordETController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  final bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Set Password', style: screenTitleTextStyle),
                const SizedBox(height: 10),
                Text(
                    'Minimum length password 8 character with letter and number',
                    style: screenSubtitleTextStyle),
                const SizedBox(height: 10),
                AppTextFieldWidget(
                    obscureText: true,
                    hintText: 'Password',
                    validator: (String? value) {
                      if(value?.isEmpty ?? true) {
                        return 'Password reset field can not be empty';
                      } return null;
                    },
                    controller: _newResetPasswordETController),
                const SizedBox(height: 10),
                AppTextFieldWidget(
                    obscureText: true,
                    hintText: 'Confirm Password',
                    validator: (String? value) {
                      if((value?.isEmpty ?? true) || ((value ?? '') != _newResetPasswordETController.text)) {
                        return 'Password mismatch';
                      } return null;
                    },
                    controller: _confirmResetPasswordETController),
                const SizedBox(height: 10),
                _inProgress ? const Center(child: CircularProgressIndicator(color: Colors.green)):
                AppElevatedButton(
                    child: const Text('Confirm'),
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        final response = await NetworkUtils.postMethod(
                            Urls.recoverResetPasswordUrl,
                            body: {
                              "email": widget.email,
                              "OTP": widget.otp,
                              "password": _newResetPasswordETController.text,
                            });
                        if (response != null &&
                            response['status'] == 'success') {
                          if (mounted) {
                            showSnackBarMessage(
                                context, 'Password reset done.');
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                                (route) => false);
                          }
                        } else {
                          if (mounted) {
                            showSnackBarMessage(
                                context, 'Password reset failed', true);
                          }
                        }
                      }
                    }),
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
                                builder: (context) => const LoginScreen(),
                              ),
                              (route) => false);
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
