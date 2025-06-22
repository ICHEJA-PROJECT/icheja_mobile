import 'dart:io';

import 'package:dio/dio.dart';
import 'package:icheja_mobile/core/errors/api_exception.dart';
import 'package:icheja_mobile/core/network/domain/constants/api_client_constants.dart';
import 'package:icheja_mobile/exercises/data/models/reading_feedback_model.dart';
import 'package:icheja_mobile/exercises/data/models/writing_feedback_model.dart';

abstract class ExerciseRemoteDataSource {
  Future<ReadingFeedbackModel> evaluateReadingExercise({
    required String audioPath,
    required String objectiveSentence,
  });

  Future<WritingFeedbackModel> evaluateWritingExercise({
    required String studentImagePath,
    required String originalImagePath,
  });
}

class ExerciseRemoteDataSourceImpl implements ExerciseRemoteDataSource {
  final Dio _dio;

  ExerciseRemoteDataSourceImpl(this._dio);

  @override
  Future<ReadingFeedbackModel> evaluateReadingExercise({
    required String audioPath,
    required String objectiveSentence,
  }) async {
    try {
      final file = File(audioPath);
      if (!await file.exists()) {
        throw Exception('Audio file not found at path: $audioPath');
      }

      final formData = FormData.fromMap({
        'audio': await MultipartFile.fromFile(
          audioPath,
          filename: audioPath.split('/').last,
        ),
        'objective_sentence': objectiveSentence,
      });

      final response = await _dio.post(
        ApiClientConstants.evaluateReadingExercisePath,
        data: formData,
      );

      print('Response: ${response.data}');

      if (response.data != null) {
        return ReadingFeedbackModel.fromJson(
            response.data as Map<String, dynamic>);
      } else {
        throw ApiException(
            message: 'La respuesta de la evaluación está vacía.');
      }
    } on DioException catch (e) {
      if (e.error is ApiException) {
        throw e.error as ApiException;
      }
      throw ApiException(
          message: e.message ?? 'Error no identificado en la evaluación');
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<WritingFeedbackModel> evaluateWritingExercise(
      {required String studentImagePath,
      required String originalImagePath}) async {
    try {
      final studentImageFile = File(studentImagePath);
      if (!await studentImageFile.exists()) {
        throw Exception(
            'Student image file not found at path: $studentImagePath');
      }

      final originalImageFile = File(originalImagePath);
      if (!await originalImageFile.exists()) {
        throw Exception(
            'Original image file not found at path: $originalImagePath');
      }

      final formData = FormData.fromMap({
        'compare_img': await MultipartFile.fromFile(
          studentImagePath,
          filename: studentImagePath.split('/').last,
        ),
        'original_img': await MultipartFile.fromFile(
          originalImagePath,
          filename: originalImagePath.split('/').last,
        ),
      });

      final response = await _dio.post(
        ApiClientConstants.evaluateWritingExercisePath,
        data: formData,
      );

      print('Writing evaluation response: ${response.data}');

      if (response.data != null) {
        return WritingFeedbackModel.fromJson(
            response.data as Map<String, dynamic>);
      } else {
        throw ApiException(
            message: 'La respuesta de la evaluación de escritura está vacía.');
      }
    } on DioException catch (e) {
      if (e.error is ApiException) {
        throw e.error as ApiException;
      }
      throw ApiException(
          message: e.message ??
              'Error no identificado en la evaluación de escritura');
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
