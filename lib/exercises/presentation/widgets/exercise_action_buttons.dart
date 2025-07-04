import 'package:flutter/material.dart';
import 'package:icheja_mobile/exercises/domain/entities/exercise.dart';
import 'package:icheja_mobile/exercises/presentation/viewmodels/exercise_viewmodel.dart';
import 'package:icheja_mobile/exercises/presentation/widgets/reading_exercise_actions.dart';
import 'package:icheja_mobile/exercises/presentation/widgets/writing_exercise_actions.dart';

class ExerciseActionButtons extends StatelessWidget {
  final Exercise exercise;
  final ExerciseViewModel viewModel;

  const ExerciseActionButtons({
    super.key,
    required this.exercise,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    if (exercise.type == ExerciseType.reading) {
      return ReadingExerciseActions(viewModel: viewModel);
    } else if (exercise.type == ExerciseType.writing) {
      return WritingExerciseActions(viewModel: viewModel, onSendExercise: (){},);
    } else {
      return const SizedBox.shrink();
    }
  }
}
