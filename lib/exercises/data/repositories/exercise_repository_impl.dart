import 'package:icheja_mobile/core/errors/api_exception.dart';
import 'package:icheja_mobile/exercises/data/datasources/exercise_local_data_source.dart';
import 'package:icheja_mobile/exercises/data/datasources/exercise_remote_data_source.dart';
import 'package:icheja_mobile/exercises/domain/entities/exercise.dart';
import 'package:icheja_mobile/exercises/domain/entities/feedback_entity.dart';
import 'package:icheja_mobile/exercises/domain/repositories/exercise_repository.dart';

class ExerciseRepositoryImpl implements ExerciseRepository {
  final ExerciseLocalDataSource localDataSource;
  final ExerciseRemoteDataSource remoteDataSource;

  ExerciseRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<List<Exercise>> getExercises() async {
    try {
      final exerciseModels = await localDataSource.getExercises();
      return exerciseModels;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ReadingFeedback> evaluateReadingExercise({
    required String audioPath,
    required String objectiveSentence,
  }) async {
    try {
      final feedbackModel = await remoteDataSource.evaluateReadingExercise(
        audioPath: audioPath,
        objectiveSentence: objectiveSentence,
      );
      return feedbackModel;
    } on ApiException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
