import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icheja_mobile/common/camera/domain/repositories/camera_repository.dart';

class QRScannerViewModel extends ChangeNotifier {
  final CameraRepository _cameraRepository;

  StreamSubscription? _cameraStateSubscription;

  CameraState _state = CameraState(status: CameraStatus.initial);
  CameraState get state => _state;

  QRScannerViewModel({
    required CameraRepository cameraRepository,
  }) : _cameraRepository = cameraRepository {
    _initializeCamera();
  }

  void _initializeCamera() {
    _cameraStateSubscription =
        _cameraRepository.initializeCamera().listen((newState) {
      _state = newState;
      notifyListeners();
    });
  }

  Future<void> takePicture(BuildContext context) async {
    final file = await _cameraRepository.takePicture();
    if (file != null) {
      context.go('/home');
    }
  }

  @override
  void dispose() {
    _cameraStateSubscription?.cancel();
    _cameraRepository.dispose();
    super.dispose();
  }
}
