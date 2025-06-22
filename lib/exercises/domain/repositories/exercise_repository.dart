import 'dart:io';

import 'package:icheja_mobile/exercises/domain/entities/exercise.dart';
import 'package:icheja_mobile/exercises/domain/entities/feedback_entity.dart';

abstract class ExerciseRepository {
  Future<List<Exercise>> getExercises();
  Future<ReadingFeedback> evaluateReadingExercise({
    required String audioPath,
    required String objectiveSentence,
  });
  Future<WritingFeedbackEntity> evaluateWritingExercise({
    required File studentImage,
    required String originalImageUrl,
  });
}
