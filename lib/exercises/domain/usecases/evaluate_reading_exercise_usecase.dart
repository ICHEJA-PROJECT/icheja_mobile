import 'package:icheja_mobile/exercises/domain/entities/feedback_entity.dart';
import 'package:icheja_mobile/exercises/domain/repositories/exercise_repository.dart';

class EvaluateReadingExerciseUseCase {
  final ExerciseRepository _repository;

  EvaluateReadingExerciseUseCase(this._repository);

  Future<ReadingFeedback> call({
    required String audioPath,
    required String objectiveSentence,
  }) async {
    return await _repository.evaluateReadingExercise(
      audioPath: audioPath,
      objectiveSentence: objectiveSentence,
    );
  }
}
