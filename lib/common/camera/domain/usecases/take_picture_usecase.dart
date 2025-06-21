import 'dart:io';
import 'package:icheja_mobile/common/camera/domain/repositories/camera_repository.dart';

class TakePictureUseCase {
  final CameraRepository _repository;

  TakePictureUseCase(this._repository);

  Future<File?> call() async {
    return await _repository.takePicture();
  }
}
