import 'package:icheja_mobile/home/data/datasources/progress_local_data_source.dart';
import 'package:icheja_mobile/home/domain/entities/progress_entity.dart';
import 'package:icheja_mobile/home/domain/repositories/progress_repository.dart';

class ProgressRepositoryImpl implements ProgressRepository {
  final ProgressLocalDataSource localDataSource;

  ProgressRepositoryImpl({required this.localDataSource});

  @override
  Future<List<ProgressEntity>> getProgress() async {
    return await localDataSource.getProgress();
  }
}
