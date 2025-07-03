import 'package:get_it/get_it.dart';
import 'package:icheja_mobile/resources/presentation/viewmodels/resources_viewmodel.dart';

void setupResourcesDependencies(GetIt sl) {
  // ViewModel
  sl.registerFactory(() => ResourcesViewmodel(sl()));
}
