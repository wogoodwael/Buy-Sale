import 'package:flutter/material.dart';

class CountiesRow extends StatefulWidget {
  const CountiesRow({super.key, required this.country_name});
  final String country_name;

  @override
  State<CountiesRow> createState() => _CountiesRowState();
}

class _CountiesRowState extends State<CountiesRow> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          widget.country_name,
          style: TextStyle(fontSize: 20),
        ),
        Checkbox(
            fillColor: MaterialStateProperty.resolveWith((states) {
              if (!states.contains(MaterialState.selected)) {
                return Colors.white;
              }
              return null;
            }),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
            side: BorderSide(
              color: Colors.white,
              width: 1,
            ),
            activeColor: Colors.green,
            checkColor: Colors.white,
            value: rememberMe,
            onChanged: (val) {
              setState(() {
                rememberMe = val!;
              });
            }),
      ],
    );
  }
}
