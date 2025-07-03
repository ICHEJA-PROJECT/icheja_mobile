import 'package:flutter/material.dart';

class ModalHeader extends StatelessWidget {
  final String? title;
  final Color? titleColor;
  final String? subtitle;
  final double titleFontSize;
  final double subtitleFontSize;

  const ModalHeader({
    super.key,
    required this.title,
    this.titleColor,
    this.subtitle,
    this.titleFontSize = 24.0,
    this.subtitleFontSize = 14.0,
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
              fontSize: titleFontSize,
              fontWeight: FontWeight.w900,
              color: titleColor ?? Colors.black87,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: subtitleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
