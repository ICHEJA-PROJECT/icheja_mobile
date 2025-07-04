import 'package:icheja_mobile/resources/domain/entities/resources_entity.dart';

abstract class GetResourcesAndExercisesRepository {
  Future<List<ResourcesEntity>> getResourcesAndExercisesByField(String field);
  Future<List<ResourcesEntity>> getAllResources();
}
