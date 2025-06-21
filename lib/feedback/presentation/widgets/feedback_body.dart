import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';
import 'package:icheja_mobile/exercises/domain/entities/exercise.dart';
import 'package:icheja_mobile/exercises/domain/entities/feedback_entity.dart';
import 'package:icheja_mobile/feedback/presentation/viewmodels/feedback_viewmodel.dart';
import 'package:icheja_mobile/feedback/presentation/widgets/incorrect_words_display.dart';
import 'package:icheja_mobile/feedback/presentation/widgets/media_comparison_display.dart';
import 'package:icheja_mobile/feedback/presentation/widgets/precision_display.dart';
import 'package:icheja_mobile/feedback/presentation/widgets/reading_feedback_details.dart';
import 'package:icheja_mobile/feedback/presentation/widgets/writing_feedback_details.dart';
import 'package:icheja_mobile/feedback/presentation/widgets/feedback_tts_section.dart';
import 'package:provider/provider.dart';

class FeedbackBody extends StatelessWidget {
  final Exercise exercise;
  const FeedbackBody({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    final feedback = exercise.retroalimentacion;
    final viewModel = context.watch<FeedbackViewModel>();
    final isLectura = exercise.type == ExerciseType.reading;
    String feedbackType = isLectura ? 'lectura' : 'escritura';

    String? textToSpeak;
    if (feedback is WritingFeedback) {
      textToSpeak =
          'Tu nivel es ${feedback.level}. La precisión de tu trazo es del ${(feedback.structuralSimilarity * 100).toInt()} por ciento.';
      if (feedback.retroalimentacion != null &&
          feedback.retroalimentacion!.isNotEmpty) {
        textToSpeak += ' ${feedback.retroalimentacion}';
      }
    } else if (feedback is ReadingFeedback) {
      textToSpeak =
          'Tu precisión de pronunciación fue del ${feedback.precision.toInt()} por ciento.';
      if (feedback.palabrasIncorrectas?.isNotEmpty ?? false) {
        textToSpeak +=
            ' Las palabras con errores fueron: ${feedback.palabrasIncorrectas!.join(', ')}.';
      }
      if (feedback.retroalimentacion != null &&
          feedback.retroalimentacion!.isNotEmpty) {
        textToSpeak += ' ${feedback.retroalimentacion}';
      }
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
          if (feedback is WritingFeedback)
            WritingFeedbackDetails(feedback: feedback),
          if (feedback is ReadingFeedback)
            ReadingFeedbackDetails(feedback: feedback),
          const SizedBox(height: 12),
          MediaComparisonDisplay(exercise: exercise),
        ],
      ),
    );
  }
}
