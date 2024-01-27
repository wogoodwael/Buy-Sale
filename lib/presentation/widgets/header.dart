import 'package:flutter/material.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: .9 * mediawidth(context),
            height: .15 * mediaHiegh(context),
            decoration: BoxDecoration(
                color: brawn,
                borderRadius:
                    const BorderRadius.only(bottomRight: Radius.circular(100))),
            child: Center(
              child: Text(
                "4Buy&sale",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: .04 * mediaHiegh(context),
          ),
          Center(
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
        ],
      ),
    );
  }
}
