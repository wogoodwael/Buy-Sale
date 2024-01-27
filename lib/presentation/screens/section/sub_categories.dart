import 'package:flutter/material.dart';

import 'package:shopping/presentation/screens/section/sub_category_row.dart';

class SubCategorieScreen extends StatelessWidget {
  const SubCategorieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 70,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 20,
              child: Image.asset("images/Filter.png"),
            ),
            Center(
                child: Text(
              "اسم القسم الأساسى",
              style: TextStyle(
                fontFamily: "PlusJakartaSans-Bold",
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff1111111),
              ),
            )),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_forward,
                size: 20,
              ),
            ),
          ]),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 500,
          height: 500,
          child: Column(
            children: [SubCategoryRow()],
          ),
        )
      ]),
    );
  }
}
