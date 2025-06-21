import 'package:icheja_mobile/home/data/mock/progress_mock.dart';
import 'package:icheja_mobile/home/data/models/progress_model.dart';

abstract class ProgressLocalDataSource {
  Future<List<ProgressModel>> getProgress();
}

class ProgressLocalDataSourceImpl implements ProgressLocalDataSource {
  @override
  Future<List<ProgressModel>> getProgress() async {
    // Simulate a network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return progressMock.map((e) => ProgressModel.fromJson(e)).toList();
  }
}
