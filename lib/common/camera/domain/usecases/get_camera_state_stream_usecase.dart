import 'dart:async';
import 'package:icheja_mobile/common/camera/domain/repositories/camera_repository.dart';

class GetCameraStateStreamUseCase {
  final CameraRepository repository;

  GetCameraStateStreamUseCase(this.repository);

  Stream<CameraState> call() {
    return repository.cameraStateStream;
  }
}
