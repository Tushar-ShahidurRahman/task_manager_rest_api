import 'package:flutter/material.dart';
import 'package:task_manager_rest_api/data/auth_utils.dart';
import 'package:task_manager_rest_api/data/network_utils.dart';
import 'package:task_manager_rest_api/data/urls.dart';
import 'package:task_manager_rest_api/ui/utils/snackbar_message.dart';
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
  TextEditingController subjectETController = TextEditingController();
  TextEditingController descriptionETController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _inProgress = false;

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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        Text('Add New Task', style: screenTitleTextStyle),
                        const SizedBox(height: 24),
                        AppTextFieldWidget(
                          hintText: 'subject',
                          controller: subjectETController,
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return "please enter a subject";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        AppTextFieldWidget(
                          hintText: 'Description',
                          controller: descriptionETController,
                          maxLines: 8,
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return "please enter description";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        if (_inProgress)
                          const Center(child: CircularProgressIndicator())
                        else
                          AppElevatedButton(
                              child:
                                  const Icon(Icons.arrow_circle_right_rounded),
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  _inProgress = true;
                                  setState(() {});
                                  final result = await NetworkUtils.postMethod(
                                    Urls.createNewTaskUrl,
                                    token: AuthUtils.token,
                                    body: {
                                      "title": subjectETController.text.trim(),
                                      "description":
                                          descriptionETController.text.trim(),
                                      "status": "New"
                                    },
                                  );
                                  _inProgress = false;
                                  setState(() {});
                                  if (result != null &&
                                      result['status'] == 'success') {
                                    subjectETController.clear();
                                    descriptionETController.clear();
                                    showSnackBarMessage(
                                        context, 'New Task added');
                                  } else {
                                    showSnackBarMessage(context,
                                        'New Task add failed, try again', true);
                                  }
                                }
                              }),
                      ],
                    ),
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
