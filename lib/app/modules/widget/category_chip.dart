import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final int index;
  final VoidCallback? onTap;

  static const List<Color> _colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.teal,
  ];

  const CategoryChip({
    super.key,
    required this.label,
    required this.index,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Couleur choisie selon l'index modulo la longueur de la liste
    final Color color = _colors[index % _colors.length];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}