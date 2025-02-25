import 'package:flutter/material.dart';
import 'package:shopping/core/utils/strings.dart';

CustomSnackBar(BuildContext context, String text, Color color) {
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

CustomCenter(String text) {
  return Center(
    child: Text(text),
  );
}
