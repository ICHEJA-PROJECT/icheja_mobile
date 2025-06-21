import 'package:flutter/material.dart';
import 'package:icheja_mobile/exercises/presentation/viewmodels/exercise_viewmodel.dart';
import 'package:icheja_mobile/exercises/presentation/widgets/exercise_content.dart';
import 'package:provider/provider.dart';

class ExerciseView extends StatelessWidget {
  const ExerciseView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ExerciseViewModel>(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            if (viewModel.isLoading)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else if (viewModel.errorMessage != null)
              Expanded(
                child: Center(
                  child: Text(viewModel.errorMessage!),
                ),
              )
            else if (viewModel.currentExercise != null)
              Expanded(
                child: ExerciseContent(
                  exercise: viewModel.currentExercise!,
                ),
              )
            else
              const Expanded(
                child: Center(
                  child: Text('No exercises found.'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
