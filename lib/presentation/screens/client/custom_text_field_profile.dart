import 'package:flutter/material.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.hinttext, required this.controller});
  final String hinttext;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: .9 * mediawidth(context),
      height: 50,
      decoration: BoxDecoration(
          border: Border.all(color: brawn),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hinttext,
            hintTextDirection: TextDirection.rtl,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
