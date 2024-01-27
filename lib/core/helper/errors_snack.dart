import 'package:flutter/material.dart';
import 'package:shopping/core/utils/strings.dart';

class Errors {
  ErrorSnackBar(BuildContext context, String text, Color color) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        showCloseIcon: true,
        closeIconColor: Colors.white,
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: mediaHiegh(context) - 120,
          left: 10,
          right: 10,
        ),
        content: Text(text)));
  }
}
