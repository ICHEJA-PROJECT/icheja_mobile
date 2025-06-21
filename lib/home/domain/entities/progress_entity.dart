import 'package:flutter/material.dart';

enum ProgressCategory { lectura, escritura }

class ProgressEntity {
  final String title;
  final int percentage;
  final IconData icon;
  final Color color;
  final ProgressCategory category;

  ProgressEntity({
    required this.title,
    required this.percentage,
    required this.icon,
    required this.color,
    required this.category,
  });
}
