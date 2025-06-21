import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';

class FeedbackTtsSection extends StatelessWidget {
  final bool isSpeaking;
  final VoidCallback onPressed;

  const FeedbackTtsSection(
      {super.key, required this.isSpeaking, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: ColorTheme.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: Icon(isSpeaking ? Icons.stop : Icons.volume_up),
            color: ColorTheme.text,
            iconSize: 32,
            onPressed: onPressed,
          ),
        ),
        const SizedBox(width: 16),
        const Expanded(
          child: Text(
            'Retroalimentación',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
