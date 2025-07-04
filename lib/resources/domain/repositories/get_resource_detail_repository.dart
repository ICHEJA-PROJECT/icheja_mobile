import 'package:icheja_mobile/resources/domain/entities/resource_detail_entity.dart';

abstract class GetResourceDetailRepository {
  Future<ResourceDetailEntity> getResourceDetail({
    required String title,
    required String field,
  });
}
