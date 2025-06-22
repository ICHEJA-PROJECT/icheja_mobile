import 'package:flutter/material.dart';
import 'package:icheja_mobile/exercises/domain/entities/exercise.dart';
import 'package:icheja_mobile/exercises/domain/entities/feedback_entity.dart';
import 'package:icheja_mobile/feedback/presentation/viewmodels/feedback_viewmodel.dart';
import 'package:icheja_mobile/feedback/presentation/widgets/media_comparison_display.dart';
import 'package:icheja_mobile/feedback/presentation/widgets/reading_feedback_details.dart';
import 'package:icheja_mobile/feedback/presentation/widgets/writing_feedback_details.dart';
import 'package:icheja_mobile/feedback/presentation/widgets/feedback_tts_section.dart';
import 'package:provider/provider.dart';

class FeedbackBody extends StatelessWidget {
  final Exercise exercise;
  final FeedbackEntity feedback;

  const FeedbackBody({
    super.key,
    required this.exercise,
    required this.feedback,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FeedbackViewModel>();

    String? textToSpeak;
    if (feedback is ReadingFeedback) {
      final readingFeedback = feedback as ReadingFeedback;
      textToSpeak =
          'Tu precisión de pronunciación fue del ${readingFeedback.score.toInt()} por ciento.';
      if (readingFeedback.words.isNotEmpty) {
        textToSpeak +=
            ' Las palabras con errores fueron: ${readingFeedback.words.join(', ')}.';
      }
    } else if (feedback is WritingFeedbackEntity) {
      final writingFeedback = feedback as WritingFeedbackEntity;
      textToSpeak =
          'Tu nivel es ${writingFeedback.level}. La precisión de tu trazo es del ${writingFeedback.precision.toInt()} por ciento.';
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Retroalimentación',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          if (textToSpeak != null && textToSpeak.trim().isNotEmpty) ...[
            FeedbackTtsSection(
              isSpeaking: viewModel.isSpeaking,
              onPressed: () {
                if (viewModel.isSpeaking) {
                  viewModel.stop();
                } else {
                  viewModel.speak(textToSpeak!);
                }
              },
            ),
            const SizedBox(height: 24),
          ],
          if (feedback is WritingFeedbackEntity)
            WritingFeedbackDetails(feedback: feedback as WritingFeedbackEntity),
          if (feedback is ReadingFeedback)
            ReadingFeedbackDetails(feedback: feedback as ReadingFeedback),
          const SizedBox(height: 12),
          MediaComparisonDisplay(exercise: exercise),
        ],
      ),
    );
  }
}
