import 'package:bus_reservation_udemy/utils/app_decoration_style.dart';
import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final IconData? prefixIcon;
  final TextInputType? textInputType;
  final Function(String) onChanged;
  final String hint;
  final FocusNode focusNode;
  final bool obsecure;
  const TextFieldCustom({
    super.key,
    required this.controller,
    this.prefixIcon,
    required this.hint,
    required this.onChanged,
    this.textInputType,
    this.obsecure = false,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        obscureText: obsecure,
        focusNode: focusNode,
        controller: controller,
        onChanged: onChanged,
        keyboardType: textInputType,
        decoration: AppDecorationStyle.inputDecoration(prefixIcon: prefixIcon,hint: hint,),
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter your $hint";
          }
          return null;
        },
      ),
    );
  }
}
