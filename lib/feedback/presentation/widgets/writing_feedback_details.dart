import 'package:flutter/material.dart';
import 'package:icheja_mobile/exercises/domain/entities/feedback_entity.dart';
import 'package:icheja_mobile/feedback/presentation/widgets/feedback_metric.dart';
import 'package:icheja_mobile/feedback/presentation/widgets/precision_display.dart';

class WritingFeedbackDetails extends StatelessWidget {
  final WritingFeedbackEntity feedback;
  const WritingFeedbackDetails({super.key, required this.feedback});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Precisión del Trazo',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 15),
        PrecisionDisplay(precision: feedback.precision),
        const SizedBox(height: 24),
        FeedbackMetric(
          label: 'Nivel',
          value: feedback.level,
        ),
        const SizedBox(height: 8),
        const SizedBox(height: 24),
      ],
    );
  }
}
