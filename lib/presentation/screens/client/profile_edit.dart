import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker_widget/image_picker_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/data/services/apis.dart';
import 'package:shopping/presentation/screens/client/custom_text_field_profile.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  File? choosen_file;
  ApiServices apiServices = ApiServices();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController location = TextEditingController();
  String? img;
  String? fname;
  String? lname;
  String? hemail;
  String? hgender;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdata();
  }

  void getuserdata() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    img = sharedPreferences.getString("img_path")!;
    fname = sharedPreferences.getString("user_name");
    lname = sharedPreferences.getString("last_name");
    hemail = sharedPreferences.getString("email");
    hgender = sharedPreferences.getString("gender");
    setState(() {
      img;
      fname;
      lname;
      hemail;
      hgender;
    });
    print(img);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(width: .34 * mediawidth(context)),
                Center(
                  child: Text(" حساب تعريفي ",
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 18, fontWeight: FontWeight.w700)),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: grey, borderRadius: BorderRadius.circular(30)),
                    child: const Icon(
                      Icons.arrow_forward,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Stack(children: [
              CircleAvatar(
                radius: 40,
                backgroundImage:
                    NetworkImage("https://buyandsell2024.com/$img"),
              ),
              Positioned(
                  right: 1,
                  bottom: 1,
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, editProfile);
                    },
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          color: darkbrawn,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: ImagePickerWidget(
                          editIcon: Icon(
                            Icons.camera_alt,
                            color: brawn,
                            size: 15,
                          ),
                          backgroundColor: Colors.white,
                          diameter: 50,
                          fit: BoxFit.none,
                          shape: ImagePickerWidgetShape.circle,
                          isEditable: true,
                          shouldCrop: true,
                          imagePickerOptions:
                              ImagePickerOptions(imageQuality: 65),
                          onChange: (file) {
                            print("I changed the file to: ${file.path}");
                            setState(() {
                              choosen_file = File(file.path);
                            });
                          },
                        ),
                      ),
                    ),
                  ))
            ]),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  " الاسم الاول ",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "",
                    fontSize: 15,
                  ),
                ),
                //!
                CustomTextField(
                  hinttext: fname ?? "",
                  controller: firstName,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text("الاسم الاخير",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "",
                      fontSize: 15,
                    )),
                CustomTextField(
                  hinttext: lname ?? "",
                  controller: lastName,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text("الايميل",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "",
                      fontSize: 15,
                    )),
                CustomTextField(
                  hinttext: hemail ?? "alex@gmail.com",
                  controller: email,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "تاريخ الميلاد",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "",
                    fontSize: 15,
                  ),
                  textDirection: TextDirection.ltr,
                ),
                CustomTextField(
                  hinttext: "24 فبراير 1996",
                  controller: birthday,
                ),
                SizedBox(
                  height: 5,
                ),
                Text("جنس",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "",
                      fontSize: 15,
                    )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 20),
                  width: .4 * mediawidth(context),
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: brawn),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: gender,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hgender,
                        hintTextDirection: TextDirection.rtl,
                        suffixIcon: Icon(
                          Icons.check,
                          color: darkbrawn,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Text(
                    "موقع",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "",
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: .9 * mediawidth(context),
              height: 150,
              decoration: BoxDecoration(
                  border: Border.all(color: brawn),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: TextFormField(
                  controller: location,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "يكتب",
                    hintTextDirection: TextDirection.rtl,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () async {
                await apiServices.updateProfile(
                    choosenFile: choosen_file,
                    firstName: firstName.text,
                    lastName: lastName.text,
                    email: email.text,
                    gender: gender.text);
              },
              child: Container(
                width: .8 * mediawidth(context),
                height: 50,
                child: const Center(child: Text("حفظ التغيير")),
                decoration: BoxDecoration(
                  color: grey,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      )),
    );
  }
}
