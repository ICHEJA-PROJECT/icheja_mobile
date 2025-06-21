import 'dart:io';

abstract class CameraRepository {
  Future<File?> takePicture();
}
