import 'dart:io';
import 'package:icheja_mobile/common/camera/domain/repositories/camera_repository.dart';
import 'package:image_picker/image_picker.dart';

class CameraRepositoryImpl implements CameraRepository {
  final ImagePicker _imagePicker;

  CameraRepositoryImpl(this._imagePicker);

  @override
  Future<File?> takePicture() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    return File(image.path);
  }
}
