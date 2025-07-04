import 'package:icheja_mobile/home/domain/entities/resource.dart';
import 'package:icheja_mobile/home/domain/entities/topic_content_entity.dart';

abstract class GetResourcesRepository {
  Future<List<Resource>> getResources();
  Future<TopicContentEntity?> getTopicContentByName(String topicName);
  Future<ExerciseEntity?> getExerciseByIndex(
      String topicName, int exerciseIndex);
}
