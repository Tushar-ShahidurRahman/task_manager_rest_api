import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class NetworkUtils {
//getMethond

  static Future<dynamic> getMethod(String url, {VoidCallback? onUnAuthorized}) async {
    try {
      final http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        print('Unauthorized');
      } else {
        print('Something went wrong');
      }
    } catch (e) {
      print(e);
    }
  }

  // postMethod
  static Future<dynamic> postMethod(String url, {Map<String, String>? body, VoidCallback? onUnAuthorized}) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        if(onUnAuthorized != null) {
          onUnAuthorized();
        }
      } else {
        print('Something went wrong');
      }
    } catch (e) {
      print(e);
    }
  }
}
