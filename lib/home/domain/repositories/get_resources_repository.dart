import 'package:icheja_mobile/home/domain/entities/resource.dart';

abstract class GetResourcesRepository {
  Future<List<Resource>> getResources();
}
