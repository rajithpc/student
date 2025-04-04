import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({super.key, required this.onSearch});
  final Function(String) onSearch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: onSearch,
        decoration: InputDecoration(
          hintText: 'Search student here',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
