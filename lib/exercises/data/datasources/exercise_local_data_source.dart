import 'package:icheja_mobile/exercises/data/mock/exercises_mock.dart';
import 'package:icheja_mobile/exercises/data/models/exercise_model.dart';

abstract class ExerciseLocalDataSource {
  Future<List<ExerciseModel>> getExercises();
}

class ExerciseLocalDataSourceImpl implements ExerciseLocalDataSource {
  @override
  Future<List<ExerciseModel>> getExercises() async {
    // Simulate a network delay
    await Future.delayed(const Duration(milliseconds: 1500));
    final exercises = exercisesMock
        .map((exercise) => ExerciseModel.fromJson(exercise))
        .toList();
    return exercises;
  }
}
