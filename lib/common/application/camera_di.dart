import 'package:get_it/get_it.dart';
import 'package:icheja_mobile/common/camera/data/repositories/camera_repository_impl.dart';
import 'package:icheja_mobile/common/camera/domain/repositories/camera_repository.dart';
import 'package:icheja_mobile/common/camera/domain/usecases/take_picture_usecase.dart';
import 'package:image_picker/image_picker.dart';

void setupCameraDependencies(GetIt getIt) {
  // External
  getIt.registerLazySingleton<ImagePicker>(() => ImagePicker());

  // Repositories
  getIt.registerLazySingleton<CameraRepository>(
      () => CameraRepositoryImpl(getIt()));

  // Use cases
  getIt.registerLazySingleton(() => TakePictureUseCase(getIt()));
}
