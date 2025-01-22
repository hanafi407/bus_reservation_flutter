import 'package:flutter/material.dart';

class SearchButtonCustom extends StatefulWidget {
  final Function(String) onButton;
  const SearchButtonCustom({super.key, required this.onButton});

  @override
  State<SearchButtonCustom> createState() => _SearchButtonCustomState();
}

class _SearchButtonCustomState extends State<SearchButtonCustom> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                if (_controller.text.isEmpty) return;
                widget.onButton(_controller.text);
              },),),
    );
  }
}
