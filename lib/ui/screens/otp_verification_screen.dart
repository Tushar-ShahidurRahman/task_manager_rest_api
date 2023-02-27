import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_rest_api/ui/screens/login_screen.dart';
import 'package:task_manager_rest_api/ui/widgets/app_elevated_button.dart';
import 'package:task_manager_rest_api/ui/widgets/screen_background_widget.dart';

import '../utils/text_style.dart';
import '../widgets/app_text_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  static const String pageText =
      'A 6 digit verification pin will send to your email address';

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
            AppElevatedButton(child: const Text('Verify'), onTap: () {}),
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
      )),
    );
  }
}
