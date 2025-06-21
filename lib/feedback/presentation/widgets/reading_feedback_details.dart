import 'package:flutter/material.dart';
import 'package:icheja_mobile/exercises/domain/entities/feedback_entity.dart';
import 'package:icheja_mobile/feedback/presentation/widgets/incorrect_words_display.dart';
import 'package:icheja_mobile/feedback/presentation/widgets/precision_display.dart';

class ReadingFeedbackDetails extends StatelessWidget {
  final ReadingFeedback feedback;
  const ReadingFeedbackDetails({super.key, required this.feedback});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Precisión de Pronunciación',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        PrecisionDisplay(precision: feedback.precision),
        const SizedBox(height: 24),
        if (feedback.palabrasIncorrectas?.isNotEmpty ?? false) ...[
          const Text(
            'Palabras incorrectas',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          IncorrectWordsDisplay(words: feedback.palabrasIncorrectas!),
          const SizedBox(height: 24),
        ]
      ],
    );
  }
}
