import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker_widget/image_picker_widget.dart';

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
              const CircleAvatar(
                radius: 40,
                backgroundImage: ExactAssetImage("images/person2.png"),
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
                          editIcon: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 25,
                          ),
                          backgroundColor: Colors.white,
                          diameter: 50,
                          fit: BoxFit.none,
                          initialImage: AssetImage("images"),
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
                  hinttext: 'Andy',
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
                  hinttext: 'Lexsian',
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
                  hinttext: "Andylexian22@gmail.com",
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
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
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
                            hintText: 'ذكر',
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
                    Container(
                      width: .4 * mediawidth(context),
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: brawn),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: TextFormField(
                          controller: gender,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'انثي',
                            hintTextDirection: TextDirection.rtl,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
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
