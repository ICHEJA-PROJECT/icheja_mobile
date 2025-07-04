import 'package:icheja_mobile/home/domain/entities/topic_content_entity.dart';
import 'package:icheja_mobile/home/domain/repositories/get_resources_repository.dart';

class GetTopicContentByNameUseCase {
  final GetResourcesRepository _repository;

  GetTopicContentByNameUseCase(this._repository);

  Future<TopicContentEntity?> call(String topicName) async {
    return await _repository.getTopicContentByName(topicName);
  }
}