import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:icheja_mobile/common/camera/domain/repositories/camera_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraRepositoryImpl implements CameraRepository {
  CameraController? _controller;
  final _cameraStateController = StreamController<CameraState>.broadcast();

  @override
  Stream<CameraState> get cameraStateStream => _cameraStateController.stream;

  @override
  Future<void> initializeCamera() async {
    _cameraStateController.add(CameraState(status: CameraStatus.loading));
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
          _cameraStateController.add(CameraState(
            status: CameraStatus.success,
            controller: _controller,
          ));
        } else {
          _cameraStateController.add(CameraState(
            status: CameraStatus.failure,
            errorMessage: 'No se encontraron cámaras disponibles.',
          ));
        }
      } else {
        _cameraStateController.add(CameraState(
          status: CameraStatus.failure,
          errorMessage: 'Se necesita permiso de la cámara para continuar.',
        ));
      }
    } on CameraException catch (e) {
      _cameraStateController.add(CameraState(
        status: CameraStatus.failure,
        errorMessage: 'Error de cámara: ${e.description}',
      ));
    } catch (e) {
      _cameraStateController.add(CameraState(
        status: CameraStatus.failure,
        errorMessage: 'Ocurrió un error inesperado: $e',
      ));
    }
  }

  @override
  Future<File?> takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      // Maybe emit a failure state?
      return null;
    }
    try {
      final file = await _controller!.takePicture();
      return File(file.path);
    } catch (e) {
      _cameraStateController.add(CameraState(
          status: CameraStatus.failure,
          errorMessage: 'Error al tomar la foto: $e',
          controller: _controller));
      return null;
    }
  }

  @override
  Future<void> dispose() async {
    await _controller?.dispose();
    await _cameraStateController.close();
  }
}
