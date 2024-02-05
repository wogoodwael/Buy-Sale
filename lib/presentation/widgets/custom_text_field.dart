import 'package:flutter/material.dart';
import 'package:shopping/core/utils/strings.dart';


class AdvTextField extends StatelessWidget {
  const AdvTextField({super.key, required this.text,required this.controller});
  final String text;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
            padding: EdgeInsets.only(right: 30, top: 10, bottom: 5),
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )),
        Center(
            child: Container(
          width: .85 * mediawidth(context),
          height: 40,
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: TextField(
              textDirection: TextDirection.rtl,
            controller: controller,
            decoration: InputDecoration(border: InputBorder.none),
          ),
        )),
      ],
    );
  }
}
