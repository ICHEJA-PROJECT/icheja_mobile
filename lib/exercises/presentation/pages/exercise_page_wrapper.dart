import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:icheja_mobile/core/application/dependency_injection.dart';
import 'package:icheja_mobile/exercises/presentation/viewmodels/exercise_viewmodel.dart';
import 'exercise_page.dart';

class ExercisePageWrapper extends StatelessWidget {
  final String indexExercise;
  final String fieldNameSelected;

  const ExercisePageWrapper(
      {super.key,
      required this.fieldNameSelected,
      required this.indexExercise});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final viewModel = sl<ExerciseViewModel>();
        viewModel.loadExercise(fieldNameSelected, int.parse(indexExercise));
        return viewModel;
      },
      child: ExercisePage(fieldNameSelected: fieldNameSelected),
    );
  }
}
