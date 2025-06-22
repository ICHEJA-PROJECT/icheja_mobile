import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:icheja_mobile/auth/data/datasources/auth_remote_data_source.dart';
import 'package:icheja_mobile/auth/data/repositories/auth_repository_impl.dart';
import 'package:icheja_mobile/auth/domain/repositories/auth_repository.dart';
import 'package:icheja_mobile/auth/domain/usecases/login_with_qr_usecase.dart';
import 'package:icheja_mobile/auth/presentation/viewmodels/qr_scanner_viewmodel.dart';
import 'package:icheja_mobile/common/camera/domain/repositories/camera_repository.dart';

void setupAuthDI(GetIt sl) {
  // Data sources
  sl.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: sl<Dio>()),
  );

  // Repositories
  sl.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      sessionManager: sl(),
    ),
  );

  // Use cases
  sl.registerFactory(
    () => LoginWithQrUseCase(repository: sl<AuthRepository>()),
  );

  // View models
  sl.registerFactory(
    () => QRScannerViewModel(
      cameraRepository: sl<CameraRepository>(),
      loginWithQrUseCase: sl<LoginWithQrUseCase>(),
      sessionManager: sl(),
    ),
  );
}
