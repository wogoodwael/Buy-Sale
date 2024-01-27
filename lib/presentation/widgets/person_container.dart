import 'package:flutter/material.dart';
import 'package:shopping/core/utils/strings.dart';

class PersonContainer extends StatelessWidget {
  const PersonContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: .9 * mediawidth(context),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.menu,
                size: 40,
                color: Color(0xff935C09),
              ),
              CircleAvatar(
                backgroundImage: ExactAssetImage("images/Ellipse.png"),
                radius: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
