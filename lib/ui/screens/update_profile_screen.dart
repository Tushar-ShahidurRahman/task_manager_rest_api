import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_rest_api/data/auth_utils.dart';
import 'package:task_manager_rest_api/data/network_utils.dart';
import 'package:task_manager_rest_api/data/urls.dart';
import 'package:task_manager_rest_api/ui/utils/snackbar_message.dart';
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
  final TextEditingController _emailETController = TextEditingController();
  final TextEditingController _firstNameETController = TextEditingController();
  final TextEditingController _lastNameETController = TextEditingController();
  final TextEditingController _mobileETController = TextEditingController();
  final TextEditingController _passwordETController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();
  XFile? pickedImage;
  String? base64Image;
  bool _inProgress = false;

  // _UpdateProfileScreenState(this.pickedImage);

  @override
  void initState() {
    super.initState();
    _emailETController.text = AuthUtils.email ?? '';
    _firstNameETController.text = AuthUtils.firstName ?? '';
    _lastNameETController.text = AuthUtils.lastName ?? '';
    _mobileETController.text = AuthUtils.mobile ?? '';

    // passwordETController.text = AuthUtils.
  }

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
                          Text('Update Profile', style: screenTitleTextStyle),
                          const SizedBox(height: 14),
                          InkWell(
                            onTap: () async {
                              await pickImage();
                            },
                            child: Row(
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
                                    child: Center(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          pickedImage?.name ??
                                              'No photo chosen',
                                          maxLines: 1,
                                          style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          AppTextFieldWidget(
                            hintText: 'Email',
                            readOnly: true,
                            controller: _emailETController,
                          ),
                          const SizedBox(height: 14),
                          AppTextFieldWidget(
                            hintText: 'First Name',
                            controller: _firstNameETController,
                            validator: (String? value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please your first name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),
                          AppTextFieldWidget(
                            hintText: 'Last Name',
                            controller: _lastNameETController,
                            validator: (String? value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),
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
                          const SizedBox(height: 14),
                          AppTextFieldWidget(
                            hintText: 'Password',
                            controller: _passwordETController,
                          ),
                          const SizedBox(height: 14),
                          _inProgress
                              ? const Center(
                                  child: CircularProgressIndicator(
                                  color: Colors.green,
                                ))
                              : AppElevatedButton(
                                  child: const Icon(
                                      Icons.arrow_circle_right_rounded),
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      updateProfile();
                                    }
                                  },
                                ),
                        ],
                      ),
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

  Future<void> pickImage() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select image Source'),
          actions: [
            ListTile(
              title: const Text('Camera'),
              leading: const Icon(Icons.camera),
              onTap: () async {
                pickedImage =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                if (pickedImage != null) {
                  //  will i save it to shared preference?
                  //  Ans turned out that no i don't save it to sp... rather i will setState...

                  setState(() {});
                  // Later i found out I will check pickedImage again in updateProfile method.
                  //  If its not null then i will convert it to base64 image.
                }
              },
            ),
            ListTile(
              title: const Text('Gallery'),
              leading: const Icon(Icons.photo_library),
              onTap: () async {
                pickedImage =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedImage != null) {
                  setState(() {});
                }
              },
            ),
          ],
        );
      },
    );
    // pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    // if (pickedImage != null) {
    //   //  will i save it to shared preference?
    //   //  Ans turned out that no i don't save it to sp... rather i will setState...
    //   setState(() {});
    // }
    // // else{
    // // //  (Wondering) will i handle this case or do nothing... how to handle this case?
    // // //  pop the context of the dialog?
    // // }
    // //   And no else is necessary. do nothing.
  }

  Future<void> updateProfile() async {
    _inProgress = true;
    setState(() {});
    if (pickedImage != null) {
      List<int> byteImage = await pickedImage!.readAsBytes();
      print(byteImage);
      base64Image = base64Encode(byteImage);
      print(base64Image);
    }

    Map<String, String> bodyParams = {
      'firstName': _firstNameETController.text.trim(),
      'lastName': _lastNameETController.text.trim(),
      'mobile': _mobileETController.text.trim(),
      'photo': base64Image ?? '',
    };

    if (_passwordETController.text.isNotEmpty) {
      bodyParams['password'] = _passwordETController.text;
    }

    final response =
        await NetworkUtils.postMethod(Urls.updateProfileUrl, body: bodyParams);

    _inProgress = false;
    setState(() {});
    // _inProgress = false;
    // setState(() {});
    //update cache data
    if (response != null && response['status'] == 'success') {
      //  Shouldn't i save it inside shared preference?
      //  let's do it
      // Todo:update cache data
      AuthUtils.saveUserData(
        userEmail: response['data']['email'],
        userFirstName: response['data']['firstName'],
        userLastName: response['data']['lastName'],
        userProfilePic: response['data']['photo'],
        userMobile: response['data']['mobile'],
        userToken: response['token'],
      );
      // showSnackBarMessage(context, 'Profile data updated');
      // setState(() {});

      // Clear all controllers from here...

      if (mounted) {
        showSnackBarMessage(context, 'Profile data updated');
        setState(() {});
        // Navigator.pop(context);
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, 'Could not update the profile, please try again', true);
      }
    }
  }
}
