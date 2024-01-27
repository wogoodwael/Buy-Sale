import 'package:flutter/material.dart';

import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';
import 'package:shopping/presentation/screens/advertisements/choose_cat.dart';
import 'package:shopping/presentation/screens/advertisements/choose_sub.dart';
import 'package:shopping/presentation/screens/countries/center_choose_container.dart';
import 'package:shopping/presentation/screens/countries/choose_city_container.dart';
import 'package:shopping/presentation/screens/countries/choose_country_container.dart';

class AdvertiseScreen extends StatefulWidget {
  const AdvertiseScreen({super.key});

  @override
  State<AdvertiseScreen> createState() => _AdvertiseScreenState();
}

class _AdvertiseScreenState extends State<AdvertiseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: mediawidth(context),
              height: .2 * mediaHiegh(context),
              decoration: BoxDecoration(
                  color: brawn,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(50))),
              child: const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Center(
                  child: Text(
                    "اضف اعلان",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
              child: Text(
                "اختر القسم الرئيسي ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            ChooseCategoriesContainer(
              top: .3 * mediaHiegh(context),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
              child: Text(
                "اختر القسم الفرعي ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            ChooseSubCategContainer(
              top: .42 * mediaHiegh(context),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
              child: Text(
                "اختر المحافظة ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            ChooseCountryContainer(
              top: .54 * mediaHiegh(context),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
              child: Text(
                "اختر المدينة ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            ChooseCityContainer(
              top: .5 * mediaHiegh(context),
            ),
            const CenterChooseContainer(),
            const Padding(
                padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
                child: Text(
                  "اسم  المنتج ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            Center(
                child: Container(
              width: .85 * mediawidth(context),
              height: 40,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: const TextField(
                decoration: InputDecoration(border: InputBorder.none),
              ),
            )),
            const Padding(
                padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
                child: Text(
                  "سعر  المنتج ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            Center(
                child: Container(
              width: .85 * mediawidth(context),
              height: 40,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: const TextField(
                decoration: InputDecoration(border: InputBorder.none),
              ),
            )),
            const Padding(
                padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
                child: Text(
                  "عنوان  البائع ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            Center(
                child: Container(
              width: .85 * mediawidth(context),
              height: 40,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: const TextField(
                decoration: InputDecoration(border: InputBorder.none),
              ),
            )),
            const Padding(
                padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
                child: Text(
                  "اسم البائع   ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            Center(
                child: Container(
              width: .85 * mediawidth(context),
              height: 40,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: const TextField(
                decoration: InputDecoration(border: InputBorder.none),
              ),
            )),
            const SizedBox(
              height: 20,
            ),
            const Padding(
                padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
                child: Text(
                  "صورة المنتج   ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                width: .8 * mediawidth(context),
                height: 150,
                decoration: BoxDecoration(
                    color: grey, borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: brawn,
                    child: const Icon(Icons.add),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
                padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
                child: Text(
                  " سعر المنتج",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            Center(
                child: Container(
              width: .85 * mediawidth(context),
              height: 40,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: const TextField(
                decoration: InputDecoration(border: InputBorder.none),
              ),
            )),
            const Padding(
                padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
                child: Text(
                  " وصف المنتج",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
            Center(
              child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  width: .75 * mediawidth(context),
                  height: 120,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: grey,
                      borderRadius: BorderRadius.circular(2)),
                  child: const TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  )),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
