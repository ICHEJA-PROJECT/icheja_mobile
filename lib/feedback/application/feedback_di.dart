import 'package:get_it/get_it.dart';
import 'package:icheja_mobile/feedback/presentation/viewmodels/feedback_viewmodel.dart';

void setupFeedbackDependencies(GetIt sl) {
  // ViewModel
  sl.registerFactory(
    () => FeedbackViewModel(
      speakUseCase: sl(),
      stopUseCase: sl(),
      getIsSpeakingStreamUseCase: sl(),
    ),
  );
}
