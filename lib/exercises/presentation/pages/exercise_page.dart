import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/layouts/app_layout.dart';
import 'package:icheja_mobile/core/application/dependency_injection.dart';
import 'package:icheja_mobile/exercises/presentation/viewmodels/exercise_viewmodel.dart';
import 'package:icheja_mobile/exercises/presentation/widgets/exercise_view.dart';
import 'package:provider/provider.dart';

class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExerciseViewModel>(
      create: (_) => getIt<ExerciseViewModel>()..loadExercises(),
      child: const AppLayout(child: ExerciseView()),
    );
  }
}
