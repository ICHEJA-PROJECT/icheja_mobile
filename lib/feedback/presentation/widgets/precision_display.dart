import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';

class PrecisionDisplay extends StatelessWidget {
  final double precision;
  const PrecisionDisplay({super.key, required this.precision});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Precisión',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: ColorTheme.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '% ${precision.toInt()}',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: ColorTheme.text,
            ),
          ),
        ),
      ],
    );
  }
}
