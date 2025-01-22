import 'package:flutter/material.dart';

class RowCustom extends StatelessWidget {
  final String label;
  final String value;
   RowCustom({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Expanded(
          flex: 5,
          child: Text(label),
        ),
        Expanded(
          flex: 7,
          child: Text(value),
        )
      ],
    );
  }
}
