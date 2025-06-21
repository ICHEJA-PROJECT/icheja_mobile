import 'package:icheja_mobile/exercises/domain/entities/exercise.dart';

abstract class ExerciseRepository {
  Future<List<Exercise>> getExercises();
}
