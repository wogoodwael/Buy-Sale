import 'package:flutter/material.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';

// ignore: must_be_immutable
class SearchContainer extends StatelessWidget {
  SearchContainer({super.key});
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: .9 * mediawidth(context),
        height: 40,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(10), color: grey),
        child: Padding(
          padding: EdgeInsets.only(right: 10),
          child: TextFormField(
            controller: search,
            decoration: InputDecoration(
              hintText: "ابحث هنا عما تريد  ",
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
