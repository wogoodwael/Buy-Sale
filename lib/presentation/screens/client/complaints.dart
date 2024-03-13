import 'package:flutter/material.dart';
import 'package:shopping/core/helper/errors_snack.dart';
import 'package:shopping/core/helper/header.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/presentation/widgets/bottons.dart';
import 'package:shopping/presentation/widgets/header.dart';

class ComplaintsPage extends StatelessWidget {
  const ComplaintsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AdvertisementHeader(
              text: 'الشكاوي',
            ),
            SizedBox(
              height: .1 * mediaHiegh(context),
            ),
            Card(
              elevation: 5,
              borderOnForeground: true,
              shadowColor: brawn,
              child: Container(
                width: 350,
                height: .3 * mediaHiegh(context),
                decoration: BoxDecoration(
                    color: Colors.white, border: Border.all(color: brawn)),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'قم بكتابة شكوتك ',
                        hintTextDirection: TextDirection.rtl),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: .05 * mediaHiegh(context),
            ),
            GestureDetector(
                onTap: () async {
                  CustomSnackBar(context, 'تم ارسال الشكوي', Colors.green);
                  await Future.delayed(
                      const Duration(seconds: 2)); // Wait for 2 seconds
                  Navigator.pop(context);
                },
                child: const CustomSignButton(
                  text: 'ارسال ',
                )),
            const SizedBox(
              height: 10,
            ),
            MaterialButton(
              minWidth: .9 * mediawidth(context),
              height: .07 * mediaHiegh(context),
              color: brawn,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () {
                Navigator.pushNamed(context, home);
              },
              child: const Text(
                "الرجوع الي الرئيسية",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
