import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/data/models/menu_item.dart';

class ItemList extends StatelessWidget {
  const ItemList({super.key, required this.menuItemModel});
  final MenuItemModel menuItemModel;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        menuItemModel.text,
        style: GoogleFonts.cairo(
          fontSize: 17,
          fontWeight: FontWeight.w700,
        ),
        textDirection: TextDirection.rtl,
      ),
      leading: IconButton(
        icon: Icon(
          menuItemModel.icon,
          size: 20,
          color: brawn,
        ),
        onPressed: menuItemModel.ontap,
      ),
    );
  }
}
