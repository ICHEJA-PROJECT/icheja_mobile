import 'package:get_it/get_it.dart';
import 'package:icheja_mobile/common/camera/data/repositories/camera_repository_impl.dart';
import 'package:icheja_mobile/common/camera/domain/repositories/camera_repository.dart';

final getIt = GetIt.instance;

void setupCameraDI() {
  getIt.registerFactory<CameraRepository>(() => CameraRepositoryImpl());
}
