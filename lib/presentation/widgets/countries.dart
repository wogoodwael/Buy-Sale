import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

import 'package:shopping/core/utils/strings.dart';

class Countries extends StatelessWidget {
  const Countries(
      {super.key, required this.country_code, required this.country_name});
  final String country_code;
  final String country_name;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: .05 * mediawidth(context)),
        width: .93 * mediawidth(context),
        height: .07 * mediaHiegh(context),
        decoration: BoxDecoration(),
        child: Row(
          children: [
            SizedBox(
              width: .1 * mediawidth(context),
            ),
            CountryFlag.fromCountryCode(
              country_code,
              width: 40,
              height: 40,
            ),
            SizedBox(
              width: .07 * mediawidth(context),
            ),
            Text(
              country_name,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      SizedBox(
        height: .04 * mediaHiegh(context),
      )
    ]);
  }
}
