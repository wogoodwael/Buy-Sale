// ignore_for_file: use_build_context_synchronously

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
import 'package:shopping/data/models/filter_model.dart';
import 'package:shopping/data/models/government_model.dart';
import 'package:http/http.dart' as http;

import 'package:shopping/data/models/my_advertise_model.dart';
import 'package:shopping/data/models/sub_cate.dart';
import 'package:shopping/presentation/screens/client/profile.dart';

class ApiServices {
  //! update profile
  Future updateProfile(
      {required File? choosenFile,
      required String firstName,
      required String lastName,
      required String email,
      required String gender,
      required BuildContext context}) async {
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
        CustomSnackBar(context, "تم تحديث الملف الشخصي", Colors.green);
        Navigator.pop(context);
        return true;
      } else {
        print("error-----${await response.stream.bytesToString()}");
        CustomSnackBar(context,
            'تاكد من كتابه الايميل بشكل صحيح وملئ جميع الفراغات', Colors.red);
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

//^search categories api
  Future<FilterModel> getCategoryFilter({required String name}) async {
    http.Response response = await http.get(
        Uri.parse("https://buyandsell2024.com/api/category?name=$name"),
        headers: {"api-token": "gh-general"});
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("the data in filter services is ${data}");
    } else {
      print("error ${response.statusCode} ");
    }
    FilterModel filterModel = FilterModel.fromJson(data);
    return filterModel;
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
  Future postAdvertise(
      {required String name,
      required List<String> cityId,
      required String categoriesId,
      required String description,
      required List<PlatformFile> files,
      required String phone,
      required String adress,
      required String price,
      required List<String> filetype,
      required List atrributesid,
      required BuildContext context}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('login_token')!;
    print("valid token $token");
    var response = http.MultipartRequest("POST", Uri.parse(createAdvLink));

    response.headers['api-token'] = 'gh-general';
    response.headers['Authorization'] = 'Bearer $token';
    response.fields['name'] = name;
    // cityId.forEach((element) {
    //   response.fields['city_id[]'] = element;
    // });
    for (var i = 0; i < cityId.length; i++) {
      response.fields['city_id[$i]'] = cityId[i];
    }
    for (var i = 0; i < atrributesid.length; i++) {
      response.fields["attributes[$i][id]"] = atrributesid[i]['id'].toString();
      response.fields["attributes[$i][value]"] = atrributesid[i]['value'];
    }
    // response.fields['city_id'] = cityId;
    response.fields['description'] = description;
    response.fields['category_id'] = categoriesId;
    response.fields['price'] = price;
    response.fields['phone'] = phone;
    response.fields['address'] = adress;
    // response.fields['attributes'] = atrributesid;

    List<http.MultipartFile> files2 = [];
    for (PlatformFile file in files) {
      var f = await http.MultipartFile.fromPath(
          'files[$file][file_path]', file.path!);
      var t;
      for (var i = 0; i < files.length; i++) {
        t = http.MultipartFile.fromString('files[$file][type]', filetype[i]);
      }

      files2.add(f);
      files2.add(t);
    }
    print("filllllllllles$files2");
    response.files.addAll(files2);

    print(response.fields.toString());
    print(response.files.toString());
    return await response.send().then((response) async {
      if (response.statusCode == 200) {
        print("Uploaded Advertisement files!");
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        Map<String, dynamic> jsonMap = jsonDecode(responseString);
        if (jsonMap['status'] == true) {
          print('truuuuuuue');
          CustomSnackBar(context, "تم انشاء الاعلان بنجاح", Colors.green);
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()));
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
  Future<AdvertismentModel> getAdvertisement({required String id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  

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

//!delete adv
  Future deleteAdv({required BuildContext context, required int id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("login_token")!;
    http.Response response = await http.delete(
      Uri.parse("https://buyandsell2024.com/api/advertisement/$id"),
      headers: {"api-token": "gh-general", "Authorization": "Bearer $token"},
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (data['status'] == true) {
        print("adv deleted successfully");
      } else {
        print("error in data status $data");
      }
    } else {
      print("error in status code ${response.statusCode}");
    }
  }
}
