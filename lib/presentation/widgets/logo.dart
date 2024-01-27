import 'package:flutter/material.dart';
import 'package:shopping/core/utils/strings.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: .20 * mediawidth(context),
        top: .07 * mediaHiegh(context),
      ),
      width: .60 * mediawidth(context),
      height: .25 * mediaHiegh(context),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/logo.png"), fit: BoxFit.cover)),
      // color: Colors.amber,
    );
  }
}
