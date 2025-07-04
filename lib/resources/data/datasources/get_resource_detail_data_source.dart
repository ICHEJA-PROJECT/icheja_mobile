import 'package:icheja_mobile/core/data/datasource/mock/mock_data.dart';
import 'package:icheja_mobile/resources/domain/entities/abecedary_resource_entity.dart';
import 'package:icheja_mobile/resources/domain/entities/family_resource_entity.dart';
import 'package:icheja_mobile/resources/domain/entities/resource_detail_entity.dart';
import 'package:icheja_mobile/resources/domain/repositories/get_resource_detail_repository.dart';

class GetResourceDetailDataSource implements GetResourceDetailRepository {
  @override
  Future<ResourceDetailEntity> getResourceDetail({
    required String title,
    required String field,
  }) async {
    final cleanedData = content.where((e) => e["Recursos"].isNotEmpty).toList();
    if (cleanedData.isEmpty) {
      throw Exception("No resources found for the field: $field");
    }
    final findResourced = cleanedData
        .where((e) => e["Recursos"][0]["titulo"] == title)
        .firstOrNull;

    if (findResourced == null) {
      throw Exception("No resources found with the title: $title");
    }

    final resource = findResourced["Recursos"][0];

    if (resource == null) {
      throw Exception("No resources found for the field: $field");
    }

    List res = [];
    if (resource["titulo"] == "Abecedario con señas") {
      res = resource["material"].map<AbecedaryResourceEntity>((e) {
        return AbecedaryResourceEntity(
            vocal: e["vocal"],
            minusVocal: e["minus_vocal"],
            imageUrl: e["path_image"]);
      }).toList();
    }else if (resource["titulo"] == "Familia") {
      res = resource["material"].map<FamilyResourceEntity>((e) {
        return FamilyResourceEntity(
          role: e["rol"],
          imgPath: e["path_image"],
        );
      }).toList();
    }

    return ResourceDetailEntity(
      id: "${field}_${resource["titulo"]}",
      title: resource["titulo"],
      content: res,
    );
  }
}
