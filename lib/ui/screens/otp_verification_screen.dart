import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_rest_api/data/urls.dart';
import 'package:task_manager_rest_api/ui/screens/login_screen.dart';
import 'package:task_manager_rest_api/ui/screens/set_new_password_screen.dart';
import 'package:task_manager_rest_api/ui/utils/snackbar_message.dart';
import 'package:task_manager_rest_api/ui/widgets/app_elevated_button.dart';
import 'package:task_manager_rest_api/ui/widgets/screen_background_widget.dart';

import '../../data/network_utils.dart';
import '../utils/text_style.dart';
import '../widgets/app_text_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;

  const OtpVerificationScreen({Key? key, required this.email})
      : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpPinETController = TextEditingController();
  // String? otpCode;

  static const String pageText =
      'A 6 digit verification pin will send to your email address';

  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pin verification', style: screenTitleTextStyle),
            const SizedBox(height: 15),
            Text(pageText, style: screenSubtitleTextStyle),
            const SizedBox(height: 15),
            //  pin code text from here
            PinCodeTextField(
              controller: _otpPinETController,
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
                selectedColor: Colors.green,
                selectedFillColor: Colors.white,
                inactiveFillColor: Colors.white,
                // activeColor: Colors.green,
                // inactiveColor: Colors.white,
                // disabledColor: Colors.white,
              ),
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: Colors.transparent,
              enableActiveFill: true,
              // errorAnimationController: errorController,
              // controller: textEditingController,
              onCompleted: (v) {
                print("Completed");
              },
              onChanged: (value) {
                // otpCode = value;
                print(value);
                setState(() {
                  // currentText = value;
                });
              },
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
              appContext: context,
            ),
            const SizedBox(height: 10),
            _inProgress ? const Center(child: CircularProgressIndicator(color: Colors.green)):
            AppElevatedButton(
                child: const Text('Verify'),
                onTap: () async {
                  final response = await NetworkUtils.getMethod(
                      Urls.recoveryVerifyOTPUrl(
                          email: widget.email,
                          otp: _otpPinETController.text.trim()));
                  if (response != null && response['status'] == 'success') {
                    //Todo: Maybe i need to compare otp in above line.
                    print(response['otp']);
                    // if(response[]){}
                    if (mounted) {
                      showSnackBarMessage(context, 'OTP verification done');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SetNewPasswordScreen(
                          //  Todo: pass email and otp for resetting password.
                            email: widget.email,
                            otp: _otpPinETController.text,
                          ),
                        ),
                      );
                    }
                  } else {
                    if (mounted) {
                      showSnackBarMessage(
                          context, 'Verification failed, check your OTP', true);
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
      )),
    );
  }
}
