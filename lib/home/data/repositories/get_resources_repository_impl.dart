import 'package:icheja_mobile/home/data/datasources/get_resources_data_source.dart';
import 'package:icheja_mobile/home/domain/entities/resource.dart';
import 'package:icheja_mobile/home/domain/entities/topic_content_entity.dart';
import 'package:icheja_mobile/home/domain/repositories/get_resources_repository.dart';

class GetResourcesRepositoryImpl implements GetResourcesRepository {
  final GetResourcesDataSource dataSource;

  GetResourcesRepositoryImpl({required this.dataSource});

  @override
  Future<List<Resource>> getResources() async {
    return await dataSource.getResources();
  }

  @override
  Future<TopicContentEntity?> getTopicContentByName(String topicName) async {
    return await dataSource.getTopicContentByName(topicName);
  }

  @override
  Future<ExerciseEntity?> getExerciseByIndex(String topicName, int exerciseIndex) async {
    return await dataSource.getExerciseByIndex(topicName, exerciseIndex);
  }
}
