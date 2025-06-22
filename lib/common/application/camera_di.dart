import 'package:get_it/get_it.dart';
import 'package:icheja_mobile/common/camera/data/repositories/camera_repository_impl.dart';
import 'package:icheja_mobile/common/camera/domain/repositories/camera_repository.dart';

void setupCameraDI(GetIt sl) {
  sl.registerFactory<CameraRepository>(() => CameraRepositoryImpl());
}
