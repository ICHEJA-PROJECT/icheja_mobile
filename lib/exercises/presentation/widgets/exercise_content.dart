import 'package:flutter/material.dart';
import 'package:icheja_mobile/exercises/domain/entities/exercise.dart';
import 'package:icheja_mobile/exercises/presentation/layouts/exercise_layout.dart';
import 'package:icheja_mobile/exercises/presentation/viewmodels/exercise_viewmodel.dart';
import 'package:icheja_mobile/exercises/presentation/widgets/exercise_action_buttons.dart';
import 'package:icheja_mobile/exercises/presentation/widgets/exercise_media_display.dart';
import 'package:provider/provider.dart';

class ExerciseContent extends StatelessWidget {
  final Exercise exercise;

  const ExerciseContent({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ExerciseViewModel>(context);

    return ExerciseLayout(
      exercise: exercise,
      isSpeaking: viewModel.isSpeaking,
      onSpeakerPressed: () {
        if (viewModel.isSpeaking) {
          viewModel.stop();
        } else {
          viewModel.speak(exercise.instrucciones);
        }
      },
      childrens: [
        ExerciseMediaDisplay(
          exercise: exercise,
          viewModel: viewModel,
        ),
        const SizedBox(height: 32),
        ExerciseActionButtons(
          exercise: exercise,
          viewModel: viewModel,
        ),
      ],
    );
  }
}
