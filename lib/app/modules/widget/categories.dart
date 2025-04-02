import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final Color color;

const CategoryChip({required this.label, required this.color, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
      return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Center(child: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold))),
    );
  }
}

class CategoryList extends StatelessWidget {
  final List<Map<String, dynamic>> categoriesList = [
    {"label": "Science", "color": Colors.blue},
    {"label": "Littérature", "color": Colors.orange},
    {"label": "Art", "color": Colors.green},
    {"label": "Musique", "color": Colors.purple},
    {"label": "Technologie", "color": Colors.red},
    {"label": "Sport", "color": Colors.teal},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categoriesList
            .map((category) => CategoryChip(
      label: category["label"], 
      color: category["color"],
))
            .toList(),
      ),
    );
  }
}
