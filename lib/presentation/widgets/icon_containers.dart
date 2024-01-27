import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({super.key, required this.img});
  final String img;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 50,
        height: 50,
        child: Center(
          child: Image.asset(img),
        ),
      ),
    );
  }
}
