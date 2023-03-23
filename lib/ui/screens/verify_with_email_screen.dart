import 'package:flutter/material.dart';
import 'package:task_manager_rest_api/data/network_utils.dart';
import 'package:task_manager_rest_api/ui/screens/otp_verification_screen.dart';
import 'package:task_manager_rest_api/ui/utils/snackbar_message.dart';
import 'package:task_manager_rest_api/ui/utils/text_style.dart';
import 'package:task_manager_rest_api/ui/widgets/app_elevated_button.dart';
import 'package:task_manager_rest_api/ui/widgets/app_text_button.dart';
import 'package:task_manager_rest_api/ui/widgets/app_text_field_widget.dart';
import 'package:task_manager_rest_api/ui/widgets/screen_background_widget.dart';

import '../../data/urls.dart';

class VerifyWithEmailScreen extends StatefulWidget {
  // final String email;
  const VerifyWithEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyWithEmailScreen> createState() => _VerifyWithEmailScreenState();
}

class _VerifyWithEmailScreenState extends State<VerifyWithEmailScreen> {
  bool _inProgress = false;
  final TextEditingController _emailETController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    const String pageText =
        'A 6 digit verification pin will send to your email address';
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
                Text('Your Email Address', style: screenTitleTextStyle),
                const SizedBox(height: 15),
                Text(pageText, style: screenSubtitleTextStyle),
                const SizedBox(height: 15),
                AppTextFieldWidget(
                  hintText: 'Email',
                  controller: _emailETController,
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Provide your email please';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                _inProgress ? const Center(child: CircularProgressIndicator(color: Colors.green)):
                AppElevatedButton(
                  child: const Icon(Icons.arrow_circle_right_rounded),
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      final response = await NetworkUtils.getMethod(
                          Urls.recoveryByEmailVerificationUrl(
                              email: _emailETController.text.trim()));
                      if(response != null && response['status'] == 'success') {

                        if(mounted) {
                          showSnackBarMessage(context, 'Sent OTP in your email');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtpVerificationScreen(email: _emailETController.text.trim(),),
                            ));
                      }} else {
                        if(mounted) {
                          showSnackBarMessage(context, 'Could not send any OTP', true);
                        }
                      }

                    }
                  },
                ),
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
        ),
      )),
    );
  }
}
