import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icheja_mobile/common/camera/domain/repositories/camera_repository.dart';
import 'package:icheja_mobile/common/camera/domain/usecases/dispose_camera_usecase.dart';
import 'package:icheja_mobile/common/camera/domain/usecases/get_camera_state_stream_usecase.dart';
import 'package:icheja_mobile/common/camera/domain/usecases/initialize_camera_usecase.dart';
import 'package:icheja_mobile/common/camera/domain/usecases/take_picture_usecase.dart';

class QRScannerViewModel extends ChangeNotifier {
  final InitializeCameraUseCase _initializeCameraUseCase;
  final DisposeCameraUseCase _disposeCameraUseCase;
  final TakePictureUseCase _takePictureUseCase;
  final GetCameraStateStreamUseCase _getCameraStateStreamUseCase;

  StreamSubscription? _cameraStateSubscription;

  CameraState _state = CameraState(status: CameraStatus.initial);
  CameraState get state => _state;

  QRScannerViewModel({
    required InitializeCameraUseCase initializeCameraUseCase,
    required DisposeCameraUseCase disposeCameraUseCase,
    required TakePictureUseCase takePictureUseCase,
    required GetCameraStateStreamUseCase getCameraStateStreamUseCase,
  })  : _initializeCameraUseCase = initializeCameraUseCase,
        _disposeCameraUseCase = disposeCameraUseCase,
        _takePictureUseCase = takePictureUseCase,
        _getCameraStateStreamUseCase = getCameraStateStreamUseCase {
    _initializeCamera();
  }

  void _initializeCamera() {
    _cameraStateSubscription =
        _getCameraStateStreamUseCase().listen((newState) {
      _state = newState;
      notifyListeners();
    });
    _initializeCameraUseCase();
  }

  Future<void> takePicture(BuildContext context) async {
    final file = await _takePictureUseCase();
    if (file != null) {
      print('Foto guardada en: ${file.path}');
      context.go('/home');
      // Aquí es donde después enviaremos la imagen a la API.
    }
  }

  @override
  void dispose() {
    _cameraStateSubscription?.cancel();
    _disposeCameraUseCase();
    super.dispose();
  }
}
