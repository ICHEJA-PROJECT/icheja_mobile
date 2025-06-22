import 'dart:io';

import 'package:dio/dio.dart';
import 'package:icheja_mobile/core/errors/api_exception.dart';
import 'package:icheja_mobile/exercises/data/datasources/exercise_local_data_source.dart';
import 'package:icheja_mobile/exercises/data/datasources/exercise_remote_data_source.dart';
import 'package:icheja_mobile/exercises/domain/entities/exercise.dart';
import 'package:icheja_mobile/exercises/domain/entities/feedback_entity.dart';
import 'package:icheja_mobile/exercises/domain/repositories/exercise_repository.dart';
import 'package:path_provider/path_provider.dart';

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

  @override
  Future<WritingFeedbackEntity> evaluateWritingExercise(
      {required File studentImage, required String originalImageUrl}) async {
    final tempDir = await getTemporaryDirectory();
    final tempPath =
        '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png';
    final dio = Dio();

    try {
      print('Downloading image from: $originalImageUrl');
      await dio.download(originalImageUrl, tempPath);

      final result = await remoteDataSource.evaluateWritingExercise(
        studentImagePath: studentImage.path,
        originalImagePath: tempPath,
      );
      return result;
    } on ApiException {
      rethrow;
    } catch (e) {
      rethrow;
    } finally {
      final tempFile = File(tempPath);
      if (await tempFile.exists()) {
        await tempFile.delete();
      }
    }
  }
}
