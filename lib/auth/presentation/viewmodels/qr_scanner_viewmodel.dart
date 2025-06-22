import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icheja_mobile/auth/domain/usecases/login_with_qr_usecase.dart';
import 'package:icheja_mobile/common/camera/domain/repositories/camera_repository.dart';
import 'package:icheja_mobile/core/session/session_manager.dart';

class QRScannerViewModel extends ChangeNotifier {
  final CameraRepository _cameraRepository;
  final LoginWithQrUseCase _loginWithQrUseCase;
  final SessionManager _sessionManager;

  StreamSubscription? _cameraStateSubscription;

  CameraState _state = CameraState(status: CameraStatus.initial);
  CameraState get state => _state;

  bool _isLoggingIn = false;
  bool get isLoggingIn => _isLoggingIn;

  QRScannerViewModel({
    required CameraRepository cameraRepository,
    required LoginWithQrUseCase loginWithQrUseCase,
    required SessionManager sessionManager,
  })  : _cameraRepository = cameraRepository,
        _loginWithQrUseCase = loginWithQrUseCase,
        _sessionManager = sessionManager {
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
    if (_isLoggingIn) return;

    _isLoggingIn = true;
    notifyListeners();

    try {
      final file = await _cameraRepository.takePicture();
      if (file != null) {
        print('Picture taken, sending to backend...');
        final userInfo = await _loginWithQrUseCase(file);
        await _sessionManager.saveSession(userInfo);
        print('Login successful for ${userInfo.name}, navigating to home...');
        context.go('/home');
      }
    } catch (e) {
      print('An error occurred during login: $e');
      // Optionally, show an error message to the user
    } finally {
      _isLoggingIn = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _cameraStateSubscription?.cancel();
    _cameraRepository.dispose();
    super.dispose();
  }
}
