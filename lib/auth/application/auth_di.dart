import 'package:get_it/get_it.dart';
import 'package:icheja_mobile/auth/presentation/viewmodels/qr_scanner_viewmodel.dart';
import 'package:icheja_mobile/common/camera/domain/repositories/camera_repository.dart';

final getIt = GetIt.instance;

void setupAuthDI() {
  getIt.registerFactory(
    () => QRScannerViewModel(
      cameraRepository: getIt<CameraRepository>(),
    ),
  );
}
