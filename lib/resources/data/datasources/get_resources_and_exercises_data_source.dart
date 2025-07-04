import 'package:icheja_mobile/core/data/datasource/mock/mock_data.dart';
import 'package:icheja_mobile/core/router/domain/constants/app_routes_constant.dart';
import 'package:icheja_mobile/resources/domain/entities/resources_entity.dart';
import 'package:icheja_mobile/resources/domain/repositories/get_resources_and_exercises_repository.dart';

class GetResourcesAndExercisesDataSource
    implements GetResourcesAndExercisesRepository {
  @override
  Future<List<ResourcesEntity>> getResourcesAndExercisesByField(
      String field) async {
    final data = content.where((e) => e["Tema"] == field).firstOrNull;

    if (data == null) {
      throw Exception("No resources found for the field: $field");
    }

    final resource = data["Recursos"];
    final exercises = data["Ejercicios"];

    if (resource == null || exercises == null) {
      throw Exception("No resources or exercises found for the field: $field");
    }

    final List<ResourcesEntity> res = [];
    if (resource.length > 0) {
      res.add(ResourcesEntity(
          id: '0',
          title: data["Tema"],
          imageUrl:
              'https://previews.123rf.com/images/matriyoshka/matriyoshka1510/matriyoshka151000021/46276042-science-and-international-education-classroom-university-professor-theory-teacher-college-lecture.jpg',
          routeToGo: '/resources/${data["Tema"]}'));
    }
    int idx = 0;
    for (var exercise in exercises) {
      res.add(ResourcesEntity(
        id: idx.toString(),
        title: exercise["titulo"],
        imageUrl: exercise["media_instrucciones"]['media'],
        routeToGo: '${AppRoutesConstant.exercises}${exercise["id"]}',
      ));
      idx++;
    }

    return res;
  }
}
