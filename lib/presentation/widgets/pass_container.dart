import 'package:flutter/material.dart';
import 'package:shopping/core/utils/colors.dart';
import 'package:shopping/core/utils/strings.dart';

class PassContainer extends StatefulWidget {
  const PassContainer({super.key, required this.hint, required this.pass});
  final String hint;
 final TextEditingController pass;
  @override
  State<PassContainer> createState() => _PassContainerState();
}

class _PassContainerState extends State<PassContainer> {
  bool visable = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: .05 * mediawidth(context)),
      width: .9 * mediawidth(context),
      height: .07 * mediaHiegh(context),
      decoration: BoxDecoration(
          color: lightGrey, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: TextFormField(
          controller: widget.pass,
          textDirection: TextDirection.rtl,
          obscureText: !visable,
          decoration: InputDecoration(
              prefixIcon: !visable
                  ? IconButton(
                      icon: Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          visable = !visable;
                        });
                      },
                    )
                  : IconButton(
                      icon: Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          visable = !visable;
                        });
                      },
                    ),
              border: InputBorder.none,
              hintText: widget.hint,
              hintStyle:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              hintTextDirection: TextDirection.rtl),
        ),
      ),
    );
  }
}
