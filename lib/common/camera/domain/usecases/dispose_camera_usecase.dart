import 'package:icheja_mobile/common/camera/domain/repositories/camera_repository.dart';

class DisposeCameraUseCase {
  final CameraRepository repository;

  DisposeCameraUseCase(this.repository);

  Future<void> call() {
    return repository.dispose();
  }
}
