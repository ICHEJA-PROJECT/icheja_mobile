import 'package:icheja_mobile/home/data/datasources/get_resources_data_source.dart';
import 'package:icheja_mobile/home/domain/entities/resource.dart';
import 'package:icheja_mobile/home/domain/repositories/get_resources_repository.dart';

class GetResourcesRepositoryImpl implements GetResourcesRepository {
  final GetResourcesDataSource dataSource;

  GetResourcesRepositoryImpl({required this.dataSource});

  @override
  Future<List<Resource>> getResources() async {
    return await dataSource.getResources();
  }
}
