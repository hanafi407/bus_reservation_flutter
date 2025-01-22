import 'package:flutter/material.dart';

class AppDecorationStyle {
  static InputDecoration inputDecoration({
    void Function()? onPress,
    IconData? iconVisibilityOff,
    IconData? iconVisibility,
    bool isObsecure=false,
    String hint = "",
    IconData? prefixIcon,
  }) {
    return InputDecoration(
      label: prefixIcon == null ? Text(hint) : null,
      suffixIcon: iconVisibilityOff == null
          ? null
          : IconButton(
              onPressed: onPress,
              icon:isObsecure? Icon(iconVisibilityOff): Icon(iconVisibility),
            ),
      prefixIcon: prefixIcon == null
          ? null
          : Icon(
              prefixIcon,
              size: 40,
            ),
      prefixStyle: const TextStyle(color: Colors.yellow),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      hintText: prefixIcon == null ? null : "Enter $hint...",
    );
  }
}
