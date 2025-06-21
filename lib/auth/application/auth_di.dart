import 'package:get_it/get_it.dart';
import 'package:icheja_mobile/auth/presentation/viewmodels/qr_scanner_viewmodel.dart';
import 'package:icheja_mobile/common/camera/domain/usecases/dispose_camera_usecase.dart';
import 'package:icheja_mobile/common/camera/domain/usecases/get_camera_state_stream_usecase.dart';
import 'package:icheja_mobile/common/camera/domain/usecases/initialize_camera_usecase.dart';
import 'package:icheja_mobile/common/camera/domain/usecases/take_picture_usecase.dart';

void setupAuthDependencies(GetIt sl) {
  // ViewModels
  sl.registerFactory(
    () => QRScannerViewModel(
      initializeCameraUseCase: sl<InitializeCameraUseCase>(),
      disposeCameraUseCase: sl<DisposeCameraUseCase>(),
      takePictureUseCase: sl<TakePictureUseCase>(),
      getCameraStateStreamUseCase: sl<GetCameraStateStreamUseCase>(),
    ),
  );
}
