import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/data/services/apis.dart';
import 'package:shopping/presentation/screens/categories/categories_screen.dart';
import 'package:shopping/presentation/screens/home/home_container.dart';

import 'package:shopping/presentation/widgets/search_container.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class HomeBody extends StatefulWidget {
  HomeBody({super.key, this.user_name});
  String? user_name;

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  ApiServices apiServices = ApiServices();

  getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('user_name')!;
    setState(() {
      widget.user_name = username;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  void _launchDeepLink() async {
    const url =
        'https://buyandsell2024.com/signup'; // Replace with your app's deep link
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.user_name ?? "",
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: "",
                    color: Colors.grey,
                  ),
                  textDirection: TextDirection.ltr,
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  "اهلا بك",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "",
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Text(
              'عن ماذا ستبحث اليوم ؟',
              style: TextStyle(
                  fontFamily: "PlusJakartaSans-Bold",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: brawn),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 45),
            child: GestureDetector(
              onTap: () {
                RouteSettings settings = ModalRoute.of(context)!.settings;

                // Print the settings
                print('Settings: ${settings}');
                _launchDeepLink();
              },
              child: Text(
                "لدينا كل ما تحتاجه",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20, color: brawn),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // SearchContainer(),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              width: .9 * mediawidth(context),
              height: 200,
              decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage("images/TownGate.png")),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: .4 * mediawidth(context),
              ),
              Text(
                "الأقسام",
                style: GoogleFonts.poppins(fontSize: 22),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 90),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => CategoriesScreen()));
                  },
                  child: Text(
                    "المزيد",
                    style: TextStyle(color: brawn, fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          //تكملت التاب بار
          const HomeContainer()
        ],
      ),
    );
  }
}
