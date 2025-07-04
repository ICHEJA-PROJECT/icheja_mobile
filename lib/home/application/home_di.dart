import 'package:get_it/get_it.dart';
import 'package:icheja_mobile/home/data/datasources/get_resources_data_source.dart';
import 'package:icheja_mobile/home/data/datasources/progress_local_data_source.dart';
import 'package:icheja_mobile/home/data/repositories/progress_repository_impl.dart';
import 'package:icheja_mobile/home/data/repositories/get_resources_repository_impl.dart';
import 'package:icheja_mobile/home/domain/repositories/progress_repository.dart';
import 'package:icheja_mobile/home/domain/repositories/get_resources_repository.dart';
import 'package:icheja_mobile/home/domain/usecases/get_progress.dart';
import 'package:icheja_mobile/home/domain/usecases/get_resources.dart';
import 'package:icheja_mobile/home/presentation/viewmodels/home_viewmodel.dart';

void setupHomeDependencies(GetIt sl) {
  // ViewModel
  sl.registerFactory(() => HomeViewModel(sl(), sl(), sl(), sl(), sl(), sl()));

  // Usecases
  sl.registerLazySingleton(() => GetProgressUseCase(sl()));
  sl.registerLazySingleton(() => GetResourcesUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<ProgressRepository>(
      () => ProgressRepositoryImpl(localDataSource: sl()));
  sl.registerLazySingleton<GetResourcesRepository>(
      () => GetResourcesRepositoryImpl(dataSource: sl()));

  // Datasources
  sl.registerLazySingleton<ProgressLocalDataSource>(
      () => ProgressLocalDataSourceImpl());
  sl.registerSingleton<GetResourcesDataSource>(GetResourcesDataSource());
}
