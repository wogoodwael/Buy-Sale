import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/data/services/apis.dart';
import 'package:shopping/presentation/screens/section/categories_screen.dart';
import 'package:shopping/presentation/screens/home/home_container.dart';

import 'package:shopping/presentation/widgets/search_container.dart';

class HomeBody extends StatefulWidget {
  HomeBody({super.key, this.user_name});
  String? user_name;

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.user_name!,
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
                Text(
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
            padding: EdgeInsets.only(right: 40),
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
            padding: EdgeInsets.only(right: 45),
            child: Text(
              "لدينا كل ما تحتاجه",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: brawn),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SearchContainer(),
          SizedBox(
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
          SizedBox(
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
                padding: EdgeInsets.only(left: 90),
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
          SizedBox(
            height: 20,
          ),
          //تكملت التاب بار
          HomeContainer()
        ],
      ),
    );
  }
}
