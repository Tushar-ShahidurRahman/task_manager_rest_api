import 'package:flutter/material.dart';
import 'package:task_manager_rest_api/ui/utils/text_style.dart';
import 'package:task_manager_rest_api/ui/widgets/app_elevated_button.dart';
import 'package:task_manager_rest_api/ui/widgets/app_text_field_widget.dart';
import 'package:task_manager_rest_api/ui/widgets/screen_background_widget.dart';
import 'package:task_manager_rest_api/ui/widgets/user_profile_tile_widget.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const UserProfileTileWidget(),
            Expanded(
              child: ScreenBackground(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        Text('Update Profile', style: screenTitleTextStyle),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              height: 40,
                              // padding: EdgeInsets.symmetric(topLeft),
                              decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      bottomLeft: Radius.circular(8))),
                              child: const Center(child: Text('Photo')),
                            ),
                            Expanded(
                              child: Container(
                                // child: Center(child: Text('Photo')),

                                height: 40,
                                // padding: EdgeInsets.symmetric(topLeft),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8))),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 14),
                        AppTextFieldWidget(
                            hintText: 'Email',
                            controller: TextEditingController()),
                        const SizedBox(height: 14),
                        AppTextFieldWidget(
                            hintText: 'First Name',
                            controller: TextEditingController()),
                        const SizedBox(height: 14),
                        AppTextFieldWidget(
                            hintText: 'Last Name',
                            controller: TextEditingController()),
                        const SizedBox(height: 14),
                        AppTextFieldWidget(
                            hintText: 'Mobile',
                            controller: TextEditingController()),
                        const SizedBox(height: 14),
                        AppTextFieldWidget(
                            hintText: 'Password',
                            controller: TextEditingController()),
                        const SizedBox(height: 14),
                        AppElevatedButton(
                            child: const Icon(Icons.arrow_circle_right_rounded),
                            onTap: () {}),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
