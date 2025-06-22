import 'package:flutter/material.dart';
import 'package:icheja_mobile/auth/presentation/layouts/auth_layout.dart';
import 'package:icheja_mobile/auth/presentation/viewmodels/qr_scanner_viewmodel.dart';
import 'package:icheja_mobile/auth/presentation/widgets/camera_preview_widget.dart';
import 'package:icheja_mobile/common/camera/domain/repositories/camera_repository.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';
import 'package:provider/provider.dart';

class QRScannerView extends StatelessWidget {
  const QRScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<QRScannerViewModel>();
    final bool isCameraReady = viewModel.state.status == CameraStatus.success;
    final bool isButtonEnabled = isCameraReady && !viewModel.isLoggingIn;

    return AuthLayout(
      childrens: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Acerca tu dispositivo al QR y escanealo, mantenlo firme y estable',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CameraPreviewWidget(cameraState: viewModel.state),
            ),
          ),
        ),
        if (viewModel.errorMessage != null)
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: Text(
              viewModel.errorMessage!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 17,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: ElevatedButton(
            onPressed:
                isButtonEnabled ? () => viewModel.takePicture(context) : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorTheme.primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: viewModel.isLoggingIn
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  )
                : const Text(
                    'Escanear QR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
