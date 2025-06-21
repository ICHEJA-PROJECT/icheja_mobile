import 'package:icheja_mobile/common/camera/domain/repositories/camera_repository.dart';

class InitializeCameraUseCase {
  final CameraRepository repository;

  InitializeCameraUseCase(this.repository);

  Future<void> call() {
    return repository.initializeCamera();
  }
}
