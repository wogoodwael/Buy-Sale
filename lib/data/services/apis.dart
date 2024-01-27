//* get governments
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/data/models/advertisement_model.dart';
import 'package:shopping/data/models/categories_model.dart';
import 'package:shopping/data/models/city_model.dart';
import 'package:shopping/data/models/government_model.dart';
import 'package:http/http.dart' as http;
import 'package:shopping/data/models/login_model.dart';
import 'package:shopping/data/models/my_advertise_model.dart';
import 'package:shopping/data/models/sub_cate.dart';

class ApiServices {
  //^register
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
    if (response.statusCode == 200) {
      if (data['status'] == true) {
        print("success to register user $data");
        Navigator.pushNamed(context, countries);
      } else {
        print(data);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Something went wrong ")));
      }

      return data['user'];
    } else {
      print("error${response.statusCode}");
    }
  }

  //^login
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
    if (response.statusCode == 200) {
      if (data['status'] == true) {
        print("success to login user $data");
        Navigator.pushNamed(context, countries);
      } else {
        print(data);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Something went wrong ")));
      }
    } else {
      print("error${response.statusCode}");
    }
    LoginModel loginModel = LoginModel.fromJson(data);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        "user_name", loginModel.data!.firstName.toString());
    sharedPreferences.setString(
        "last_name", loginModel.data!.lastName.toString());
    sharedPreferences.setString("email", loginModel.data!.email.toString());
    sharedPreferences.setString("gender", loginModel.data!.gender.toString());
    sharedPreferences.setString(
        "login_token", loginModel.data!.token.toString());

    return loginModel;
  }

  //! update profile
  Future updateProfile(
      {required File? choosenFile,
      required String firstName,
      required String lastName,
      required String email,
      required String gender}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('login_token')!;
    var response = http.MultipartRequest("POST", Uri.parse(updateProfileLink));
    response.headers['api-token'] = 'gh-general';
    response.headers['Authorization'] = 'Bearer$token';
    response.fields['email'] = email;
    response.fields['first_name'] = firstName;
    response.fields['last_name'] = lastName;
    response.fields['gender'] = gender;
    response.files.add(await http.MultipartFile.fromPath(
      'img_path',
      choosenFile!.path,
    ));
    return await response.send().then((response) async {
      if (response.statusCode == 200) {
        print("Uploaded image profile!");
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        print(responseString);

        return true;
      } else {
        print("error-----${await response.stream.bytesToString()}");
        return false;
      }
    });
  }

  //*get Governments
  Future<GovernmentModel> getGovernments() async {
    http.Response response = await http
        .get(Uri.parse(governmentLink), headers: {"api-token": "gh-general"});
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("the data in government services is ${data}");
    } else {
      print("error ${response.statusCode} ");
    }
    GovernmentModel governmentModel = GovernmentModel.fromJson(data);
    print(governmentModel.data![0].nameEn);
    return governmentModel;
  }

  //*get parent categories
  Future<CategoriesModel> getCategories() async {
    http.Response response = await http
        .get(Uri.parse(categoriesLink), headers: {"api-token": "gh-general"});

    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("the data in categories services is ${data}");
    } else {
      print("error ${response.statusCode} ");
    }
    CategoriesModel categoriesModel = CategoriesModel.fromJson(data);
    print(categoriesModel.data!.categories![0].nameAr);
    return categoriesModel;
  }

  //* get sub categories
  Future<SubCategoriesModel> getSubCategories() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String id = sharedPreferences.getString("categories_id")!;
    http.Response response = await http.get(
        Uri.parse("https://buyandsell2024.com/api/category?parent_id=${id}"),
        headers: {"api-token": "gh-general"});
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("the data in sub categories services is ${data}");
    } else {
      print("error ${response.statusCode} ");
    }
    SubCategoriesModel subCategoriesModel = SubCategoriesModel.fromJson(data);
    return subCategoriesModel;
  }

  //*get cities
  Future<CityModel> getCities() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String governid = sharedPreferences.getString("government_id")!;
    http.Response response = await http.get(
        Uri.parse("https://buyandsell2024.com/api/governorate/$governid/city"),
        headers: {
          "api-token": "gh-general",
          "Authorization":
              "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMWRjNzA2OGQ1OTY3MmVmZDUyNjk2MjA3MWM1ZTUyNGFkZGNiZjZjOGU1MTVjMGIxMTVmZjBmNDcxMGZmNWVlZmIzMThmOTk2ZTNjNzM1YjMiLCJpYXQiOjE3MDYyMjQ0NDUuOTYyOTE5LCJuYmYiOjE3MDYyMjQ0NDUuOTYyOTI0LCJleHAiOjE3Mzc4NDY4NDUuOTU1NDA3LCJzdWIiOiI0OSIsInNjb3BlcyI6W119.U10wPrRCp-E8zXspBeAW8y7O_w1whBXoJXdiNXUPmwIZTbykrcH-5cYzQn_DHdZKsaQWSuiRIZIrqTmthuRfErPwYsvFTvAA9Nmu2gsLBRebvnOTAzhSFW9DV3ma-o2wVECqNfpMALg3_UJMwEmuPicVMuM1EU4IJkPoNmbR9YKpVDkAGWJIED-lbkjUtnu0hLHSNbMzP7y0AhjzQdDx9562qcIley9aQN4GpoHkvSUfS5YJpKJLv0xqRYrFOraVpqI1UO-rYoRyI03PVQ8IoUKQoHOpp6KC2CXnp0ZnaylI9xyqt8Dsuf5Uk0SeQmN_N094pPdS3RhZ-oxUUBb5kKEbmt_bHB9g09vgprgpp2EYYujBovkDDFXeEy6MLYuVeOcIvBU-H-KrGwiHZTQTs6EQERjgJSmyKl24cGI9Mh_BNiQ-73B4VfRBZIbXDW-QzY29j1szYjuSwi95SMAzuQFPN3rR8ot6FcHkhwE2dZAsjM9j8WFEG_yhALl8zsvLFgWVUQpqvdF2g3kM2a1bfLQW0n3CdEHL_Pg2uCmxN8t-a5qllcifIu3x_bAwxDJNCee1Z8zlDJMHvZ__Yf2wFe03wmGSqdoOktp70ywYAJ9C1j5fhFOWNBU49foSsHSa23nYTx_4qRRRY4rMn10PbUlfZgH92PEifswddxdw_4A"
        });
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("the data in cities services is ${data}");
    } else {
      print("error ${response.statusCode} ");
    }
    CityModel cityModel = CityModel.fromJson(data);
    print(cityModel.data![0].nameEn);
    return cityModel;
  }

  //! post advertisement
  Future postAdvertise(
      {required String name,
      required String cityId,
      required String categoriesId,
      required String description,
      required String}) async {}

  //* get advertisement
  Future<AdvertismentModel> getAdvertisement() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("categories_id")!;
    print("iddddddddddddd$id");
    http.Response response = await http.get(
        Uri.parse(
            "https://buyandsell2024.com/api/advertisement?category_id=21"),
        headers: {
          "api-token": "gh-general",
          "Authorization":
              "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNzAzMzM3NTU3LCJuYmYiOjE3MDMzMzc1NTcsImp0aSI6IlV3RnY5NlQyZEFjOHJzT0QiLCJzdWIiOiIxIiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.m9ZDeI8NLX80fVisJr70_r4eAdn4o51KaeAbFAAlmPk"
        });
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("the data in advertisement services is ${data}");
    } else {
      print("error ${response.statusCode} ");
    }
    AdvertismentModel advertismentModel = AdvertismentModel.fromJson(data);

    return advertismentModel;
  }

  //*get my advertisement
  Future<MyAdvertisementModel> getMyAdvertise() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("login_token")!;
    http.Response response = await http.get(Uri.parse(myadvertiseLink),
        headers: {"api-token": "gh-general", "Authorization": "Bearer $token"});
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("the data in my advertise  services is ${data}");
    } else {
      print("error ${response.statusCode} ");
    }
    MyAdvertisementModel myAdvertisementModel =
        MyAdvertisementModel.fromJson(data);
    print(myAdvertisementModel.data![0].description);
    return myAdvertisementModel;
  }

  //*create comment
  Future createComment({required String content}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('login_token')!;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("categories_id")!;
    http.Response response = await http.post(Uri.parse(createCommentLink),
        headers: {"api-token": "gh-general", "Authorization": "Bearer $token"},
        body: {"content": content, "advertisement_id": 9.toString()});
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (data['status'] == true) {
        print("comment created successfully $data");
      } else {
        print("error in data status");
      }
    } else {
      print("error${response.statusCode}");
    }
  }
}
