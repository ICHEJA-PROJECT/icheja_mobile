import 'package:icheja_mobile/home/domain/entities/progress_entity.dart';

abstract class ProgressRepository {
  Future<List<ProgressEntity>> getProgress();
}
