import 'package:flutter/material.dart';

class MenuItemModel {
  final String text;
  final void Function() ontap;
  final IconData icon;

  MenuItemModel({required this.icon, required this.text, required this.ontap});
}
