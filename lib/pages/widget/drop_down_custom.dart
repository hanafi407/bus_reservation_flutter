import 'package:bus_reservation_udemy/utils/constants.dart';
import 'package:flutter/material.dart';

class DropDownCustom<T> extends StatelessWidget {
  final String? val1;
  final String? val2;
  final List<String> listString;
  final String hint;
  final void Function(String? state)? onChange;
  const DropDownCustom(
      {super.key,
      required this.val1,
      this.val2,
      required this.listString,
      required this.hint,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: val1,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return emptyFieldErrMessage;
        }
        return null;
      },
      decoration: const InputDecoration(
        errorStyle: TextStyle(color: Colors.red),
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      hint: Text(hint),
      isExpanded: true,
      items: listString
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              enabled: val2 != item,
              child: val2 == item && val2 != null
                  ? Text(
                      item,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  : Text(item),
            ),
          )
          .toList(),
      onChanged: onChange,
    );
  }
}
