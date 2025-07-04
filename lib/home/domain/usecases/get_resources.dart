import 'package:icheja_mobile/home/domain/entities/resource.dart';
import 'package:icheja_mobile/home/domain/repositories/get_resources_repository.dart';

class GetResourcesUseCase {
  final GetResourcesRepository repository;

  GetResourcesUseCase(this.repository);

  Future<List<Resource>> call() async {
    return await repository.getResources();
  }
}
