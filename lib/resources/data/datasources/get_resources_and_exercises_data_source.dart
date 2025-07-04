import 'package:icheja_mobile/common/domain/constants/ui_constants.dart';
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
          title: 'Teoría',
          imageUrl:
              'https://previews.123rf.com/images/matriyoshka/matriyoshka1510/matriyoshka151000021/46276042-science-and-international-education-classroom-university-professor-theory-teacher-college-lecture.jpg',
          routeToGo:
              '${AppRoutesConstant.resourceDetail}/${resource[0]["titulo"]}/$field'));
    }
    int idx = 1;
    for (var exercise in exercises) {
      res.add(ResourcesEntity(
        id: idx.toString(),
        title: 'Ejercicio $idx',
        imageUrl: exercise["media_instrucciones"]['media'],
        routeToGo: '${AppRoutesConstant.exercises}/$field/${idx - 1}',
      ));
      idx++;
    }

    return res;
  }

  @override
  Future<List<ResourcesEntity>> getAllResources() async {
    final data = content.where((e) => e["Recursos"].isNotEmpty).toList();
    if (data.isEmpty) {
      throw Exception("No resources found");
    }

    return data.map((e) {
      final resource = e["Recursos"][0];
      return ResourcesEntity(
        id: "0",
        title: resource["titulo"],
        imageUrl:
            'https://previews.123rf.com/images/matriyoshka/matriyoshka1510/matriyoshka151000021/46276042-science-and-international-education-classroom-university-professor-theory-teacher-college-lecture.jpg',
        routeToGo:
            '${AppRoutesConstant.resourceDetail}/${resource["titulo"]}/${UIConstants.all_resources}',
      );
    }).toList();
  }
}
