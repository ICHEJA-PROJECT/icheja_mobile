import 'dart:async';

import 'package:icheja_mobile/core/data/datasource/mock/mock_data.dart';
import 'package:icheja_mobile/home/data/models/topic_content_model.dart';
import 'package:icheja_mobile/home/domain/entities/resource.dart';
import 'package:icheja_mobile/home/domain/repositories/get_resources_repository.dart';

class GetResourcesDataSource implements GetResourcesRepository {
  @override
  Future<List<Resource>> getResources() async {
    final res = content
        .map((e) => Resource(name: e["Tema"], imageUrl: e["image"]))
        .toList();
    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 1));

    print(res);
    // Return the list of resources
    if (res.isEmpty) {
      throw Exception("No resources found");
    }
    return res;
  }

  @override
  Future<TopicContentModel?> getTopicContentByName(String topicName) async {
    // Simulate a network delay
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      // Buscar el tema en el mock
      final topicData = content.firstWhere(
        (topic) =>
            topic['Tema'].toString().toLowerCase() == topicName.toLowerCase(),
      );

      return TopicContentModel.fromJson(topicData);
    } catch (e) {
      // Si no encuentra el tema, retorna null
      return null;
    }
  }

  @override
  Future<ExerciseModel?> getExerciseByIndex(
      String topicName, int exerciseIndex) async {
    // Simulate a network delay
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      // Buscar el tema en el mock
      final topicData = content.firstWhere(
        (topic) =>
            topic['Tema'].toString().toLowerCase() == topicName.toLowerCase(),
      );

      final exercisesList = topicData['Ejercicios'] as List<dynamic>? ?? [];

      // Verificar que el índice sea válido
      if (exerciseIndex >= 0 && exerciseIndex < exercisesList.length) {
        final exerciseData =
            exercisesList[exerciseIndex] as Map<String, dynamic>;
        print(exerciseData);
        return ExerciseModel.fromJson(exerciseData);
      }

      return null;
    } catch (e) {
      return null;
    }
  }
}
