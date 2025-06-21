import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';
import 'package:icheja_mobile/exercises/domain/entities/exercise.dart';
import 'package:icheja_mobile/exercises/presentation/viewmodels/exercise_viewmodel.dart';

class ExerciseMediaDisplay extends StatelessWidget {
  final Exercise exercise;
  final ExerciseViewModel viewModel;

  const ExerciseMediaDisplay({
    super.key,
    required this.exercise,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Exercise Image
        if (exercise.rutasImagenes.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ColorTheme.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.network(
              exercise.rutasImagenes.first,
              height: 150,
              fit: BoxFit.contain,
            ),
          ),

        // Taken Picture
        if (viewModel.takenPicture != null)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ColorTheme.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.file(
                viewModel.takenPicture!,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
          ),
      ],
    );
  }
}
