import 'package:flutter/material.dart';

class ExerciseImageDisplay extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final double size;
  final double borderWidth;

  const ExerciseImageDisplay({
    super.key,
    required this.child,
    required this.borderColor,
    this.size = 300.0,
    this.borderWidth = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: child,
      ),
    );
  }
} 