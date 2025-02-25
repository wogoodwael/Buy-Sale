import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/main.dart';

class PersonContainer extends StatefulWidget {
  const PersonContainer({super.key});

  @override
  State<PersonContainer> createState() => _PersonContainerState();
}

class _PersonContainerState extends State<PersonContainer> {
  String? img;
  @override
  void initState() {
    super.initState();
    imgf();
  }

  void imgf() async {
    img = sharedpref.getString("img_path")!;
    setState(() {
      img;
    });
    print(img);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: .9 * mediawidth(context),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.menu,
                size: 40,
                color: Color(0xff935C09),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, countries);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "الرجوع للمحافظات",
                      style: GoogleFonts.cairo(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: brawn),
                      textDirection: TextDirection.rtl,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      FontAwesomeIcons.flag,
                      color: brawn,
                      size: 15,
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                radius: 38,
                backgroundColor: darkbrawn,
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: brawn,
                  backgroundImage:
                      NetworkImage("https://buyandsell2024.com/$img"),

                  // Error callback, display another image when the network image is not found
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
