import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icheja_mobile/auth/domain/usecases/login_with_qr_usecase.dart';
import 'package:icheja_mobile/common/camera/domain/repositories/camera_repository.dart';
import 'package:icheja_mobile/core/errors/api_exception.dart';
import 'package:icheja_mobile/core/router/domain/constants/app_routes_constant.dart';
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

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

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
    _errorMessage = null;
    notifyListeners();

    try {
      final file = await _cameraRepository.takePicture();
      if (file != null) {
        print('Picture taken, sending to backend...');
        final userInfo = await _loginWithQrUseCase(file);
        await _sessionManager.saveSession(userInfo);
        context.go(AppRoutesConstant.home);
      }
    } on DioException catch (e) {
      if (e.error is ApiException) {
        _errorMessage = (e.error as ApiException).message;
      } else {
        _errorMessage = 'Ocurrió un error inesperado.';
      }
    } catch (e) {
      _errorMessage = 'Ocurrió un error inesperado.';
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
