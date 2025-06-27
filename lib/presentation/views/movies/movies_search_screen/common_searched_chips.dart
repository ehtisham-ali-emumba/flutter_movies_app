import 'package:flutter/material.dart';

final List<String> searches = [
  "Comedy Movies",
  "Action Movies",
  "Drama",
  "Horror",
  "Romance",
  "Sci-Fi",
  "Thriller",
  "Documentary",
];

class CommonSearchedChips extends StatelessWidget {
  final Function(String) onSearch;

  const CommonSearchedChips({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: List.generate(
          searches.length > 8 ? 8 : searches.length,
          (index) => ActionChip(
            label: Text(searches[index]),
            onPressed: () {
              onSearch(searches[index]);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
      ),
    );
  }
}
