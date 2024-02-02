//* get governments
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/core/helper/errors_snack.dart';
import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/data/models/advertisement_model.dart';
import 'package:shopping/data/models/categories_attrs_model.dart';
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
    LoginModel loginModel = LoginModel.fromJson(data);
    try {
      if (response.statusCode == 200) {
        if (data['status'] == true) {
          print("success to login user $data");
          CustomSnackBar(context, 'تم تسجيل الدخول بنجاح', Colors.green);
          Navigator.pushNamed(context, countries);
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
    response.headers['Authorization'] = 'Bearer $token';
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

  //*get cities --change token
  Future<CityModel> getCities() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String token = sharedPreferences.getString('login_token')!;
    String governid = sharedPreferences.getString("government_choosen_id")!;
    http.Response response = await http.get(
        Uri.parse("https://buyandsell2024.com/api/governorate/$governid/city"),
        headers: {"api-token": "gh-general", "Authorization": "Bearer $token"});
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

//! get sub categories for advertisement
  Future<SubCategoriesModel> getSubCategoriesAdv() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String id = sharedPreferences.getString("adv_category_id")!;
    print("@@@@@@@@@@$id");
    http.Response response = await http.get(
        Uri.parse("https://buyandsell2024.com/api/category?parent_id=$id"),
        headers: {"api-token": "gh-general"});
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // print("the data in sub categories adv services is ${data}");
    } else {
      print("error ${response.statusCode} ");
    }
    SubCategoriesModel subCategoriesModel = SubCategoriesModel.fromJson(data);
    print(subCategoriesModel.data!.categories![0].nameAr);
    return subCategoriesModel;
  }

//* get categories attrs
  Future<GetCateAttrsModel> getCategoriesAttrs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String id = sharedPreferences.getString("sub_id")!;
    print("iddddddddddddSyb$id");
    http.Response response = await http.get(
        Uri.parse(
            "https://buyandsell2024.com/api/category_attributes?category_id=$id"),
        headers: {"api-token": "gh-general"});

    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (data['status'] == true) {
        print("the data in categories attr services is ${data}");
      } else {
        print("the data in categories attr services has error ${data}");
      }
    } else {
      print("error ${response.statusCode} ");
    }
    GetCateAttrsModel cateAttrsModel = GetCateAttrsModel.fromJson(data);
    // print(cateAttrsModel.data![0].attribute!.nameAr);
    return cateAttrsModel;
  }

  //! post advertisement
  Future postAdvertise({
    required String name,
    required var cityId,
    required String categoriesId,
    required String description,
    required PlatformFile files,
    required String phone,
    required String adress,
    required String price,
    required var atrributes0,
    required var atrributes1,
    required String filetype,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('login_token')!;
    print("valid token $token");
    var response = http.MultipartRequest("POST", Uri.parse(createAdvLink));

    response.headers['api-token'] = 'gh-general';
    response.headers['Authorization'] = 'Bearer $token';
    response.fields['name'] = name;
    response.fields['city_id'] = cityId;
    response.fields['description'] = description;
    response.fields['category_id'] = categoriesId;
    response.fields['price'] = price;
    response.fields['phone'] = phone;
    response.fields['address'] = adress;
    response.fields['attributes[0][id]'] = atrributes0;
    response.fields['attributes[0][value]'] = atrributes1;

    response.fields['files[0][type]'] = filetype;
    print("~~~~~~~~~~~~~~~");

    response.files.add(await http.MultipartFile.fromPath(
      'files[0][file_path]',
      files.path!,
    ));
    print(response.fields.toString());
    return await response.send().then((response) async {
      if (response.statusCode == 200) {
        print("Uploaded Advertisement files!");
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        Map<String, dynamic> jsonMap = jsonDecode(responseString);
        if (jsonMap['status'] == true) {
          print('truuuuuuue');
        }
        print(responseString);

        return true;
      } else {
        print("error-----${await response.stream.bytesToString()}");
        return false;
      }
    });
  }

  //* get advertisement
  Future<AdvertismentModel> getAdvertisement() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("sub_category_id")!;

    String token = prefs.getString('login_token')!;
    print("idddddddddddddofadvertisement$id");
    http.Response response = await http.get(
        Uri.parse(
            "https://buyandsell2024.com/api/advertisement?category_id=$id"),
        headers: {"api-token": "gh-general", "Authorization": "Bearer $token"});
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

//*delete comment
  Future deleteComment({required String id}) async {}
}
