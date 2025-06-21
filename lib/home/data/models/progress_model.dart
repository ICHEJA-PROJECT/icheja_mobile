import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';
import 'package:icheja_mobile/home/domain/entities/progress_entity.dart';

class ProgressModel extends ProgressEntity {
  ProgressModel({
    required super.title,
    required super.percentage,
    required super.icon,
    required super.color,
    required super.category,
  });

  factory ProgressModel.fromJson(Map<String, dynamic> json) {
    final category = json['category'] == 'lectura'
        ? ProgressCategory.lectura
        : ProgressCategory.escritura;

    return ProgressModel(
      title: json['title'],
      percentage: json['percentage'],
      category: category,
      icon: _getIconForCategory(category),
      color: _getColorForCategory(category),
    );
  }

  static IconData _getIconForCategory(ProgressCategory category) {
    switch (category) {
      case ProgressCategory.lectura:
        return Icons.book_outlined;
      case ProgressCategory.escritura:
        return Icons.edit_outlined;
    }
  }

  static Color _getColorForCategory(ProgressCategory category) {
    switch (category) {
      case ProgressCategory.lectura:
        return ColorTheme.tertiary;
      case ProgressCategory.escritura:
        return ColorTheme.primary;
    }
  }
}
