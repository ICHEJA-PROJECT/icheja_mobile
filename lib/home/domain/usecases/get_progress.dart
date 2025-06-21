import 'package:icheja_mobile/home/domain/entities/progress_entity.dart';
import 'package:icheja_mobile/home/domain/repositories/progress_repository.dart';

class GetProgressUseCase {
  final ProgressRepository _repository;

  GetProgressUseCase(this._repository);

  Future<List<ProgressEntity>> call() async {
    return await _repository.getProgress();
  }
}
