import 'package:icheja_mobile/home/domain/entities/topic_content_entity.dart';
import 'package:icheja_mobile/home/domain/repositories/get_resources_repository.dart';

class GetExerciseByIndexUseCase {
  final GetResourcesRepository _repository;

  GetExerciseByIndexUseCase(this._repository);

  Future<ExerciseEntity?> call(String topicName, int exerciseIndex) async {
    return await _repository.getExerciseByIndex(topicName, exerciseIndex);
  }
}