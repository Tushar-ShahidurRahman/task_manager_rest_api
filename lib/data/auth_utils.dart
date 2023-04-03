import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  static String? email, firstName, lastName, profilePic, mobile, token;

  static Future<void> saveUserData(
      {required String userEmail,
      required String userFirstName,
      required String userLastName,
      required String userProfilePic,
      required String userMobile,
      required String userToken}) async {
    SharedPreferences sPref = await SharedPreferences.getInstance();
    await sPref.setString('email', userEmail);
    await sPref.setString('firstName ', userFirstName);
    await sPref.setString('lastName', userLastName);
    await sPref.setString('photo', userProfilePic);
    await sPref.setString('mobile', userMobile);
    await sPref.setString('token', userToken);

    email = userEmail;
    firstName = userFirstName;
    lastName = userLastName;
    profilePic = userProfilePic;
    mobile = userMobile;
    token = userToken;
  }

  static Future<bool> checkLogInState() async {
    SharedPreferences sPref = await SharedPreferences.getInstance();
    final String? token = sPref.getString('token');
    if (token == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> getSavedAuthData() async {
    SharedPreferences sPref = await SharedPreferences.getInstance();
    email = sPref.getString('email');
    firstName = sPref.getString('firstName');
    lastName = sPref.getString('lastName');
    profilePic = sPref.getString('photo');
    mobile = sPref.getString('mobile');
    token = sPref.getString('token');
  }

  static Future<void> clearAuthData() async {
    SharedPreferences sPref = await SharedPreferences.getInstance();
    await sPref.clear();
  }
}
