import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/camera/domain/repositories/camera_repository.dart';

class CameraPreviewWidget extends StatelessWidget {
  final CameraState cameraState;

  const CameraPreviewWidget({super.key, required this.cameraState});

  @override
  Widget build(BuildContext context) {
    switch (cameraState.status) {
      case CameraStatus.loading:
      case CameraStatus.initial:
        return const Center(child: CircularProgressIndicator());
      case CameraStatus.failure:
        return Center(
          child: Text(
            cameraState.errorMessage ?? 'Ocurrió un error.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Poppins',
            ),
          ),
        );
      case CameraStatus.success:
        if (cameraState.controller == null ||
            !cameraState.controller!.value.isInitialized) {
          return const Center(
            child: Text(
              'No se pudo inicializar la cámara.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
            ),
          );
        }
        return CameraPreview(cameraState.controller!);
    }
  }
}
