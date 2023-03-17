import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager_rest_api/data/auth_utils.dart';
import 'package:task_manager_rest_api/main.dart';
import 'package:task_manager_rest_api/ui/screens/login_screen.dart';

class NetworkUtils {
//getMethod

  static Future<dynamic> getMethod(String url,
      {VoidCallback? onUnAuthorized, String? token}) async {
    try {
      final http.Response response = await http.get(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          // 'token': AuthUtils.token ?? '',
          'token': token ?? '',
        },
      );

      log(response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        if (onUnAuthorized != null) {
          onUnAuthorized();
        } else {
          moveToLogin();
        }
      } else {
        log('Something went wrong');
      }
    } catch (e) {
      log('error $e');
    }
  }

  // postMethod
  static Future<dynamic> postMethod(
    String url, {
    Map<String, String>? body,
    VoidCallback? onUnAuthorized,
    String? token,
  }) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          // 'token': AuthUtils.token ?? '',
          'token': token ?? '',
        },
        body: jsonEncode(body),
      );
      log(response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        if (onUnAuthorized != null) {
          onUnAuthorized();
        } else {
          moveToLogin();
        }
      } else {
        log('Something went wrong');
      }
    } catch (e) {
      log('Error $e');
    }
  }

  static void moveToLogin() async {
    await AuthUtils.clearAuthData();
    Navigator.pushAndRemoveUntil(
        TaskManagerApp.navigatorGlobalKey.currentContext!,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (route) => false);
  }
}
