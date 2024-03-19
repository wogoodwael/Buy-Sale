import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/main.dart';

import 'package:shopping/presentation/screens/countries/center_choose_container.dart';
import 'package:shopping/presentation/screens/countries/choose_city_container.dart';
import 'package:shopping/presentation/screens/countries/choose_country_container.dart';
import 'package:shopping/presentation/screens/home/home.dart';

class Countries extends StatefulWidget {
  const Countries({super.key});

  @override
  State<Countries> createState() => _CountriesState();
}

class _CountriesState extends State<Countries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                "قم باختيار المحافظة",
                style: TextStyle(
                    color: brawn, fontSize: 30, fontWeight: FontWeight.bold),
              )),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
                child: Text(
                  "اختار المحافظة ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              ChooseCountryContainer(
                top: .25 * mediaHiegh(context),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
                child: Text(
                  "اختار المدينة ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              ChooseCityContainer(top: .4 * mediaHiegh(context)),
              SizedBox(
                height: 30,
              ),
              //  CenterChooseContainer(),
              // CenterChooseContainer(),
              SizedBox(
                height: 40,
              ),

              const Spacer(),
              Container(
                width: mediawidth(context),
                height: 150,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/footer.png"),
                        fit: BoxFit.cover)),
                child: Center(
                  child: MaterialButton(
                    minWidth: 200,
                    color: grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () async {
                      SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      String name = sharedPreferences.getString('user_name')!;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => HomeScreen(
                                    name: name,
                                  )));
                    },
                    child: Text(
                      " التالي ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
