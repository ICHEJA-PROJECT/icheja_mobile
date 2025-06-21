import 'package:icheja_mobile/exercises/data/datasources/exercise_local_data_source.dart';
import 'package:icheja_mobile/exercises/domain/entities/exercise.dart';
import 'package:icheja_mobile/exercises/domain/repositories/exercise_repository.dart';

class ExerciseRepositoryImpl implements ExerciseRepository {
  final ExerciseLocalDataSource localDataSource;

  ExerciseRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Exercise>> getExercises() async {
    try {
      final exerciseModels = await localDataSource.getExercises();
      return exerciseModels;
    } catch (e) {
      rethrow;
    }
  }
}
