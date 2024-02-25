//!add to fav
  import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shopping/core/helper/errors_snack.dart';
import 'package:shopping/data/models/advertisement_model.dart';
Future addToFav(BuildContext context, {required int id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('login_token')!;
    http.Response response = await http.get(
      Uri.parse("https://buyandsell2024.com/api/advertisement/$id/toggle_like"),
      headers: {"api-token": "gh-general", "Authorization": "Bearer $token"},
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (data['status'] == true) {
        CustomSnackBar(context, 'تمت الاضافه الي المفضله', Colors.green);
      } else {
        print("error in favorite data $data");
      }
    } else {
      print("resonse error ${response.statusCode}");
    }
  }

//!fetch favorite
  Future<AdvertismentModel> fetchFavorites(
      {required BuildContext context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('login_token')!;
    http.Response response = await http.get(
      Uri.parse("https://buyandsell2024.com/api/my_liked_advertisement"),
      headers: {"api-token": "gh-general", "Authorization": "Bearer $token"},
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (data['status'] == true) {
        print("success favorite data $data");
      } else {
        print("error in fetch favorite data$data");
      }
    } else {
      print("error in response ${response.statusCode}");
    }
    AdvertismentModel advertismentModel = AdvertismentModel.fromJson(data);
    return advertismentModel;
  }
