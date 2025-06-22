import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:icheja_mobile/common/camera/domain/repositories/camera_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraRepositoryImpl implements CameraRepository {
  CameraController? _controller;

  @override
  Stream<CameraState> initializeCamera() async* {
    yield CameraState(status: CameraStatus.loading);
    try {
      if (await Permission.camera.request().isGranted) {
        final cameras = await availableCameras();
        if (cameras.isNotEmpty) {
          _controller = CameraController(
            cameras.first,
            ResolutionPreset.high,
            enableAudio: false,
          );
          await _controller!.initialize();
          yield CameraState(
            status: CameraStatus.success,
            controller: _controller,
          );
        } else {
          yield CameraState(
            status: CameraStatus.failure,
            errorMessage: 'No se encontraron cámaras disponibles.',
          );
        }
      } else {
        yield CameraState(
          status: CameraStatus.failure,
          errorMessage: 'Se necesita permiso de la cámara para continuar.',
        );
      }
    } on CameraException catch (e) {
      yield CameraState(
        status: CameraStatus.failure,
        errorMessage: 'Error de cámara: ${e.description}',
      );
    } catch (e) {
      yield CameraState(
        status: CameraStatus.failure,
        errorMessage: 'Ocurrió un error inesperado: $e',
      );
    }
  }

  @override
  Future<File?> takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      return null;
    }
    try {
      final file = await _controller!.takePicture();
      return File(file.path);
    } catch (e) {
      print('Error al tomar la foto: $e');
      return null;
    }
  }

  @override
  Future<void> dispose() async {
    await _controller?.dispose();
    _controller = null;
  }
}
