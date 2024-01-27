import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/presentation/screens/client/profile.dart';
import 'package:shopping/presentation/screens/home/home.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: double.infinity,
            height: 250,
            decoration: const BoxDecoration(
              color: Color(0xff935C09),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Center(
                  child: CircleAvatar(
                      backgroundImage: ExactAssetImage("images/person.png"),
                      radius: 30),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text("محمد على",
                    style: GoogleFonts.cairo(fontSize: 20, color: Colors.white))
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, countries);
              },
              child: Text("الرجوع إلى المحافظات",
                  style: GoogleFonts.cairo(
                      fontWeight: FontWeight.w700, fontSize: 17)),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () async {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                String name = sharedPreferences.getString("user_name")!;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => HomeScreen(
                              name: name,
                            )));
              },
              child: Text("الرجوع إلى الرئيسيه",
                  style: GoogleFonts.cairo(
                      fontWeight: FontWeight.w700, fontSize: 17)),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, section);
              },
              child: Text(" الاقسام الرئيسية ",
                  style: GoogleFonts.cairo(
                      fontWeight: FontWeight.w700, fontSize: 17)),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, advertise);
              },
              child: Text("  اضافه اعلان ",
                  style: GoogleFonts.cairo(
                      fontWeight: FontWeight.w700, fontSize: 17)),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              // onTap: () {
              //   Navigator.pushReplacement(
              //       context, MaterialPageRoute(builder: (_) => ChatScreen()));
              // },
              child: Text(" المحادثات  ",
                  style: GoogleFonts.cairo(
                      fontWeight: FontWeight.w700, fontSize: 17)),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ProfileScreen()));
                },
                child: Text(" الاعدادات ",
                    style: GoogleFonts.cairo(
                        fontWeight: FontWeight.w700, fontSize: 17)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
