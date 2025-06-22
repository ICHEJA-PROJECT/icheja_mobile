import 'dart:io';

import 'package:icheja_mobile/exercises/domain/entities/feedback_entity.dart';
import 'package:icheja_mobile/exercises/domain/repositories/exercise_repository.dart';

class EvaluateWritingExerciseUseCase {
  final ExerciseRepository _exerciseRepository;

  EvaluateWritingExerciseUseCase(this._exerciseRepository);

  Future<WritingFeedbackEntity> call({
    required File studentImage,
    required String originalImageUrl,
  }) async {
    return await _exerciseRepository.evaluateWritingExercise(
      studentImage: studentImage,
      originalImageUrl: originalImageUrl,
    );
  }
}
