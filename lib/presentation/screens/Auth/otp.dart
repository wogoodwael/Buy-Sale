import 'package:flutter/material.dart';

import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});
  final _otpPinFieldController = GlobalKey<OtpPinFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: .9 * mediawidth(context),
              height: .15 * mediaHiegh(context),
              decoration: BoxDecoration(
                  color: brawn,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(100))),
              child: Center(
                child: Text(
                  "4Buy&sale",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: .2 * mediaHiegh(context),
            ),
            Container(
              width: mediawidth(context),
              height: mediaHiegh(context),
              decoration: BoxDecoration(
                  color: brawn,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(80),
                      topRight: Radius.circular(80))),
              child: Column(
                children: [
                  SizedBox(
                    height: .07 * mediaHiegh(context),
                  ),
                  Text(
                    "التحقق عبر الهاتف ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  SizedBox(
                    height: .02 * mediaHiegh(context),
                  ),
                  Text(
                    "sms سنقوم بارسال رساله نصيه عبر ال  \n تحتوي علي الكود ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        height: 1),
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(
                    height: .07 * mediaHiegh(context),
                  ),
                  OtpPinField(
                      key: _otpPinFieldController,
                      autoFillEnable: false,

                      ///for Ios it is not needed as the SMS autofill is provided by default, but not for Android, that's where this key is useful.
                      textInputAction: TextInputAction.done,

                      ///in case you want to change the action of keyboard
                      /// to clear the Otp pin Controller
                      onSubmit: (text) {
                        print('Entered pin is $text');

                        /// return the entered pin
                      },
                      onChange: (text) {
                        print('Enter on change pin is $text');

                        /// return the entered pin
                      },
                      onCodeChanged: (code) {
                        print('onCodeChanged  is $code');
                      },

                      /// to decorate your Otp_Pin_Field
                      otpPinFieldStyle: OtpPinFieldStyle(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),

                        /// border color for inactive/unfocused Otp_Pin_Field
                        defaultFieldBorderColor: brawn,

                        /// border color for active/focused Otp_Pin_Field
                        activeFieldBorderColor: brawn,

                        /// Background Color for inactive/unfocused Otp_Pin_Field
                        defaultFieldBackgroundColor: grey,

                        /// Background Color for active/focused Otp_Pin_Field
                        activeFieldBackgroundColor: Colors.white,

                        /// Background Color for filled field pin box
                        filledFieldBackgroundColor: brawn,

                        /// border Color for filled field pin box
                        filledFieldBorderColor: brawn,
                      ),
                      maxLength: 5,

                      /// no of pin field
                      showCursor: true,

                      /// bool to show cursor in pin field or not
                      cursorColor: brawn,

                      /// to choose cursor color

                      middleChild: const Column(
                        children: [
                          SizedBox(height: 30),
                          SizedBox(height: 10),
                        ],
                      ),
                      showCustomKeyboard: false,
                      showDefaultKeyboard: false, //!will change it
                      cursorWidth: 3,
                      mainAxisAlignment: MainAxisAlignment.center,
                      otpPinFieldDecoration:
                          OtpPinFieldDecoration.defaultPinBoxDecoration),
                  SizedBox(
                    height: .05 * mediaHiegh(context),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ارسل مجددا ",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Text(
                        "لم يصلك الكود ؟",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: .02 * mediaHiegh(context),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, countries);
                    },
                    child: Container(
                      width: .6 * mediawidth(context),
                      height: .06 * mediaHiegh(context),
                      decoration: BoxDecoration(
                          color: grey, borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          "ارسال",
                          style: TextStyle(
                              color: brawn,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
