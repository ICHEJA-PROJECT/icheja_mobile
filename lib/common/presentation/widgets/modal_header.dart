import 'package:flutter/material.dart';

class ModalHeader extends StatelessWidget {
  final String? title;
  final Color? titleColor;
  final String? subtitle;

  const ModalHeader({
    super.key,
    required this.title,
    this.titleColor,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            title!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: titleColor ?? Colors.black87,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ],
      ),
    );
  }
} 