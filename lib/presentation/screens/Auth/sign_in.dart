import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/data/services/apis.dart';
import 'package:shopping/data/services/google_auth.dart';
import 'package:shopping/presentation/widgets/bottons.dart';
import 'package:shopping/presentation/widgets/header.dart';
import 'package:shopping/presentation/widgets/icon_containers.dart';
import 'package:shopping/presentation/widgets/pass_container.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isLoggedIn = false;
  // ignore: unused_field
  Map _iserDbi = {};
  String? userToken;
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  ApiServices apiServices = ApiServices();

  Future<void> getUserToken() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String? token = await user.getIdToken();
        print('User Token: $token');
        userToken = token;
      }
    } catch (e) {
      print('Error getting user token: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(text: 'قم بتسجيل الدخول '),
            SizedBox(
              height: .02 * mediaHiegh(context),
            ),
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: .05 * mediawidth(context)),
              width: .9 * mediawidth(context),
              height: .07 * mediaHiegh(context),
              decoration: BoxDecoration(
                  color: lightGrey, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: TextFormField(
                  textAlign: TextAlign.right,
                  controller: email,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'الايميل ',
                      hintStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      hintTextDirection: TextDirection.rtl),
                ),
              ),
            ),
            SizedBox(
              height: .04 * mediaHiegh(context),
            ),
            PassContainer(
              hint: 'كلمة السر',
              pass: password,
            ),
            SizedBox(
              height: .07 * mediaHiegh(context),
            ),
            GestureDetector(
                onTap: () async {
                  await apiServices.loginUser(
                      email: email.text,
                      password: password.text,
                      context: context);
                },
                child: const CustomSignButton(text: 'تسجيل الدخول')),
            Center(
              child: Text(
                " قم بتسجيل الدخول بواسطة ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            SizedBox(
              height: .02 * mediaHiegh(context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () async {
                      await AuthService().signInWithGoogle();
                      getUserToken();
                    },
                    child: IconContainer(img: 'images/google.png')),
                GestureDetector(
                    onTap: () async {
                      FacebookAuth.instance
                          .login(permissions: ["public_profile", "email"]).then(
                              (value) {
                        FacebookAuth.instance
                            .getUserData()
                            .then((userData) async {
                          setState(() {
                            _isLoggedIn = true;
                            _iserDbi = userData;
                          });
                          if (_isLoggedIn == true) {
                            // Navigator.pushNamed(context, 'chooseCountry');
                          }
                        });
                      });
                    },
                    child: GestureDetector(
                        onTap: () async {
                          await AuthService().signInWithGoogle();
                        },
                        child: IconContainer(img: 'images/face.png'))),
                IconContainer(img: 'images/phone.png'),
              ],
            ),
            SizedBox(
              height: .02 * mediaHiegh(context),
            ),
          ],
        ),
      ),
    );
  }
}
