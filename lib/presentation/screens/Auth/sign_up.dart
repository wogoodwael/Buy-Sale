import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/data/services/apis.dart';
import 'package:shopping/data/services/auth_api.dart';
import 'package:shopping/data/services/google_auth.dart';
import 'package:shopping/presentation/widgets/bottons.dart';
import 'package:shopping/presentation/widgets/header.dart';
import 'package:shopping/presentation/widgets/icon_containers.dart';
import 'package:shopping/presentation/widgets/pass_container.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool visable = false;
  bool _isLoggedIn = false;
  // ignore: unused_field
  Map _iserDbi = {};
  ApiServices apiServices = ApiServices();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    // Get the settings
   
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Header(
            text: ' قم بانشاء حساب ',
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: .05 * mediawidth(context)),
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
            height: .04 * mediaHiegh(context),
          ),
          PassContainer(
            hint: 'تأكيد كلمة السر',
            pass: confirmPassword,
          ),
          SizedBox(
            height: .04 * mediaHiegh(context),
          ),
          GestureDetector(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                await registerUser(
                    email: email.text,
                    password: password.text,
                    context: context);
                setState(() {
                  isLoading = false;
                });
              },
              child: isLoading
                  ? SpinKitDualRing(
                      color: brawn,
                    )
                  : const CustomSignButton(text: 'تسجيل الدخول ')),
          const Center(
            child: Text(
              " قم بتسجيل الدخول بواسطة ",
              style: TextStyle(fontWeight: FontWeight.bold),
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
                  },
                  child: const IconContainer(img: 'images/google.png')),
              GestureDetector(
                  onTap: () async {
                    FacebookAuth.instance.login(
                        permissions: ["public_profile", "email"]).then((value) {
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
                  child: const IconContainer(img: 'images/face.png')),
              const IconContainer(img: 'images/phone.png'),
            ],
          ),
          SizedBox(
            height: .02 * mediaHiegh(context),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, signIn);
                },
                child: Text(
                  " قم بتسجيل الدخول",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: brawn, fontSize: 15),
                ),
              ),
              Text(
                " هل لديك حساب بالفعل ؟ ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
