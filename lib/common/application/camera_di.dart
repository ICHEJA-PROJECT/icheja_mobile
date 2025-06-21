import 'package:get_it/get_it.dart';
import 'package:icheja_mobile/common/camera/data/repositories/camera_repository_impl.dart';
import 'package:icheja_mobile/common/camera/domain/repositories/camera_repository.dart';
import 'package:icheja_mobile/common/camera/domain/usecases/dispose_camera_usecase.dart';
import 'package:icheja_mobile/common/camera/domain/usecases/get_camera_state_stream_usecase.dart';
import 'package:icheja_mobile/common/camera/domain/usecases/initialize_camera_usecase.dart';
import 'package:icheja_mobile/common/camera/domain/usecases/take_picture_usecase.dart';

void setupCameraDependencies(GetIt sl) {
  // Use cases
  sl.registerLazySingleton(() => TakePictureUseCase(sl()));
  sl.registerLazySingleton(() => InitializeCameraUseCase(sl()));
  sl.registerLazySingleton(() => DisposeCameraUseCase(sl()));
  sl.registerLazySingleton(() => GetCameraStateStreamUseCase(sl()));

  // Repository
  sl.registerLazySingleton<CameraRepository>(
    () => CameraRepositoryImpl(),
  );
}
