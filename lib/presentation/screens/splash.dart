import 'package:flutter/material.dart';

import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brawn,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: .05 * mediaHiegh(context),
            ),
            Image.asset(
              "images/onBoarding.png",
              width: 400,
            ),
            Container(
              width: mediawidth(context),
              height:mediaHiegh(context) * .55,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: .05 * mediaHiegh(context),
                  ),
                  Text(
                    "أهلا بك فى",
                    style: TextStyle(
                        color: brawn,
                        height: 1,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "4Buy&sale",
                    style: TextStyle(
                        color: brawn,
                        height: 1,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: .04 * mediaHiegh(context),
                  ),
                  Text(
                    "هذا البرنامج مخصص للشراء والبيع لكل \nالاشياء بسهولة وسلاسة",
                    style: TextStyle(
                        fontSize: 24,
                        height: 1,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: .04 * mediaHiegh(context),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, signIn);
                    },
                    child: Container(
                      width: .5 * mediawidth(context),
                      height: .07 * mediaHiegh(context),
                      decoration: BoxDecoration(
                          color: grey, borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Text(
                          "تسجيل الدخول ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: .03 * mediaHiegh(context),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, signUp);
                        },
                        child: Text(
                          " انشئ حساب ",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: brawn),
                        ),
                      ),
                      Text(
                        "ليس لديك حساب ؟ ",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
