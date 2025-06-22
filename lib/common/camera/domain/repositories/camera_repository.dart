import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';

enum CameraStatus { initial, loading, success, failure }

class CameraState {
  final CameraStatus status;
  final CameraController? controller;
  final String? errorMessage;

  CameraState({required this.status, this.controller, this.errorMessage});
}

abstract class CameraRepository {
  Stream<CameraState> initializeCamera();
  Future<File?> takePicture();
  Future<void> dispose();
}
