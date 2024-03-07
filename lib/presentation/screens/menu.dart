import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/core/utils/colors.dart';

import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/data/models/menu_item.dart';
import 'package:shopping/main.dart';
import 'package:shopping/presentation/screens/Auth/sign_up.dart';
import 'package:shopping/presentation/screens/client/profile.dart';
import 'package:shopping/presentation/screens/home/home.dart';
import 'package:shopping/presentation/widgets/item_list.dart';

// ignore: must_be_immutable
class MenuScreen extends StatefulWidget {
  MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  MenuItemModel? menuItemModel;

  String? name;
  getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('user_name')!;
    setState(() {
      name = username;
    });
  }

  String? img;
  @override
  void initState() {
    super.initState();
    getUserName();
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
    List<MenuItemModel> items = [
      MenuItemModel(
        text: "الرجوع إلى المحافظات",
        ontap: () {
          Navigator.pushReplacementNamed(context, countries);
        },
        icon: FontAwesomeIcons.flag,
      ),
      MenuItemModel(
        text: "الرجوع إلى الرئيسيه",
        ontap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => HomeScreen()));
        },
        icon: FontAwesomeIcons.home,
      ),
      MenuItemModel(
        text: " الاقسام الرئيسية ",
        ontap: () {
          Navigator.pushReplacementNamed(context, section);
        },
        icon: FontAwesomeIcons.building,
      ),
      MenuItemModel(
        text: "  اضافه اعلان ",
        ontap: () {
          Navigator.pushReplacementNamed(context, advertise);
        },
        icon: FontAwesomeIcons.adversal,
      ),
      MenuItemModel(
        text: " تسجيل خروج  ",
        ontap: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => SignUpScreen()));
        },
        icon: Icons.exit_to_app,
      ),
      MenuItemModel(
        text: " الاعدادات ",
        ontap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => ProfileScreen()));
        },
        icon: Icons.settings,
      )
    ];

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
                Center(
                  child: CircleAvatar(
                    radius: 38,
                    backgroundColor: darkbrawn,
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          NetworkImage("https://buyandsell2024.com/$img"),

                      // Error callback, display another image when the network image is not found
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(name ?? "",
                    style: GoogleFonts.cairo(fontSize: 20, color: Colors.white))
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 400,
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: items[index].ontap,
                      child: ItemList(menuItemModel: items[index]));
                }),
          )
        ],
      ),
    );
  }
}
