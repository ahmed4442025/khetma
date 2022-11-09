import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({Key? key, this.onChanged}) : super(key: key);
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
