import 'package:flutter/material.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';

class AdvertisementHeader extends StatelessWidget {
  const AdvertisementHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mediawidth(context),
      height: .2 * mediaHiegh(context),
      decoration: BoxDecoration(
          color: brawn,
          borderRadius:
              const BorderRadius.only(bottomRight: Radius.circular(50))),
      child: const Padding(
        padding: EdgeInsets.only(top: 50),
        child: Center(
          child: Text(
            "اضف اعلان",
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
