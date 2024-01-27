import 'package:flutter/material.dart';

import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';

class CustomSignButton extends StatelessWidget {
  const CustomSignButton({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: .05 * mediawidth(context)),
          width: .9 * mediawidth(context),
          height: .07 * mediaHiegh(context),
          decoration: BoxDecoration(
              color: brawn, borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          height: .02 * mediaHiegh(context),
        ),
        const Divider(
          thickness: 1,
          endIndent: 70,
          indent: 70,
          color: Colors.black,
        ),
      ],
    );
  }
}
