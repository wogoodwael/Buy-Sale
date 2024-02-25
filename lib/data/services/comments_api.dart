  //*create comment
  import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shopping/core/helper/errors_snack.dart';
import 'package:shopping/core/utils/strings.dart';
Future createComment(
      {required String content,
      required String advId,
      required BuildContext context}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('login_token')!;
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String id = prefs.getString("categories_id")!;
    http.Response response = await http.post(Uri.parse(createCommentLink),
        headers: {"api-token": "gh-general", "Authorization": "Bearer $token"},
        body: {"content": content, "advertisement_id": advId});
    print("@@@Advvvvv $advId");
    print("@@@Advvvvv $content");
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (data['status'] == true) {
        print("comment created successfully $data");
        CustomSnackBar(context, "تم انشاء التعليق", Colors.green);
      } else {
        print("error in data status $data");
      }
    } else {
      print("error${response.statusCode}");
    }
  }

//!delete comment
  Future deleteComment(
      {required String id, required BuildContext context}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("login_token")!;
    http.Response response = await http.delete(
      Uri.parse("https://buyandsell2024.com/api/comment/$id"),
      headers: {"api-token": "gh-general", "Authorization": "Bearer $token"},
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("success delete status ");
      if (data['status'] == true) {
        print("comment deleted successfully");
        CustomSnackBar(context, 'تم حذف التعليق', Colors.green);
      } else {
        print("error in data status$data");
      }
    } else {
      print(response.statusCode);
    }
  }
