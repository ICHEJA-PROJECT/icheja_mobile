import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';
import 'package:icheja_mobile/exercises/presentation/viewmodels/exercise_viewmodel.dart';

class WritingExerciseActions extends StatelessWidget {
  final ExerciseViewModel viewModel;
  final VoidCallback onSendExercise;

  const WritingExerciseActions(
      {super.key, required this.viewModel, required this.onSendExercise});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          onPressed: () => viewModel.takePicture(),
          icon: const Icon(Icons.camera_alt, color: Colors.white),
          label: const Text(
            'Tomar Foto',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorTheme.secondary,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: viewModel.isButtonForWritingEvaluationEnabled
              ? onSendExercise
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorTheme.tertiary,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Enviar Ejercicio',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
