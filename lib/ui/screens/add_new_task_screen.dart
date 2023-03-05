import 'package:flutter/material.dart';
import 'package:task_manager_rest_api/ui/utils/text_style.dart';
import 'package:task_manager_rest_api/ui/widgets/app_elevated_button.dart';
import 'package:task_manager_rest_api/ui/widgets/app_text_field_widget.dart';
import 'package:task_manager_rest_api/ui/widgets/screen_background_widget.dart';
import 'package:task_manager_rest_api/ui/widgets/user_profile_tile_widget.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
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
                      Text('Add New Task', style: screenTitleTextStyle),
                      const SizedBox(height: 24),
                      AppTextFieldWidget(
                          hintText: 'subject',
                          controller: TextEditingController()),
                      const SizedBox(height: 10),
                      AppTextFieldWidget(
                        hintText: 'Description',
                        controller: TextEditingController(),
                        maxLines: 8,
                      ),
                      const SizedBox(height: 20),
                      AppElevatedButton(
                          child: const Icon(Icons.arrow_circle_right_rounded),
                          onTap: () {})
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
