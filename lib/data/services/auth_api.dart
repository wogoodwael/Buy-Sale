  // ignore_for_file: use_build_context_synchronously

  import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/core/helper/errors_snack.dart';
import 'package:shopping/core/utils/strings.dart';
import 'package:http/http.dart' as http;
import 'package:shopping/data/models/login_model.dart';
import 'package:shopping/presentation/screens/countries/countries_and_cities.dart';

Future registerUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    http.Response response = await http.post(Uri.parse(registerLink), headers: {
      "api-token": "gh-general"
    }, body: {
      "email": email,
      "password": password,
    });
    Map<String, dynamic> data = jsonDecode(response.body);
    try {
      if (response.statusCode == 200) {
        if (data['status'] == true) {
          print("success to register user $data");
          CustomSnackBar(context, 'تم انشاء حساب بنجاح', Colors.green);
          Navigator.pushNamed(context, signIn);
        } else {
          print(data);
          CustomSnackBar(
              context,
              'تاكد ان الايميل لم يستخدم من قبل ثم تاكد من كلمه المرور',
              Colors.red);
        }

        return data['user'];
      }
    } on Exception catch (e) {
      CustomSnackBar(context, e.toString(), Colors.red);
    }
  }

  Future<LoginModel> loginUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    http.Response response = await http.post(Uri.parse(loginLink), headers: {
      "api-token": "gh-general"
    }, body: {
      "email": email,
      "password": password,
    });
    Map<String, dynamic> data = jsonDecode(response.body);
    LoginModel loginModel = LoginModel.fromJson(data);
    try {
      if (response.statusCode == 200) {
        if (data['status'] == true) {
          print("success to login user $data");
          CustomSnackBar(context, 'تم تسجيل الدخول بنجاح', Colors.green);
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const Countries()));
        } else {
          print(data);
          CustomSnackBar(context, data['message'], Colors.red);
        }
      } else {
        print("error${response.statusCode}");
      }

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString(
          "user_name", loginModel.data!.firstName.toString());
      sharedPreferences.setString(
          "last_name", loginModel.data!.lastName.toString());
      sharedPreferences.setString("email", loginModel.data!.email.toString());
      sharedPreferences.setString("gender", loginModel.data!.gender.toString());
      sharedPreferences.setString(
          "login_token", loginModel.data!.token.toString());
      sharedPreferences.setString(
          "img_path", loginModel.data!.imgPath.toString());
    } on Exception catch (e) {
      CustomSnackBar(context, e.toString(), Colors.red);
    }
    return loginModel;
  }
