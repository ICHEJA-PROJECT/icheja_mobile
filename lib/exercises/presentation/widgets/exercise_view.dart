import 'package:flutter/material.dart';
import 'package:icheja_mobile/exercises/presentation/viewmodels/exercise_viewmodel.dart';
import 'package:icheja_mobile/exercises/presentation/widgets/exercise_content.dart';
import 'package:icheja_mobile/exercises/presentation/widgets/exercise_skeleton.dart';
import 'package:provider/provider.dart';

class ExerciseView extends StatelessWidget {
  final String fieldNameSelected;
  const ExerciseView({super.key, required this.fieldNameSelected});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ExerciseViewModel>(context, listen: true);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (viewModel.isLoading)
          const Flexible(
            child: ExerciseSkeleton(),
          )
        else if (viewModel.errorMessage != null)
          Flexible(
            child: Center(
              child: Text(viewModel.errorMessage!),
            ),
          )
        else if (viewModel.currentExercise != null)
          Flexible(
            child: ExerciseContent(
              viewModel: viewModel,
              exercise: viewModel.currentExercise!,
              isText: viewModel.exerciseMock?.texto ?? false,
              isSelection: viewModel.exerciseMock?.seleccion ?? false,
              fieldNameSelected: fieldNameSelected,
            ),
          )
        else
          const Flexible(
            child: Center(
              child: Text('No exercises found.'),
            ),
          ),
      ],
    );
  }
}
