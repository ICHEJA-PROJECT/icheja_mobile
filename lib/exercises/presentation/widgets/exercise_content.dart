import 'package:flutter/material.dart';
import 'package:icheja_mobile/exercises/domain/entities/exercise.dart';
import 'package:icheja_mobile/exercises/presentation/layouts/exercise_layout.dart';
import 'package:icheja_mobile/exercises/presentation/viewmodels/exercise_viewmodel.dart';
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
      onSend: () => viewModel.nextExercise(),
      childrens: [
        // Image
        if (exercise.rutasImagenes.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.network(
              exercise.rutasImagenes.first,
              height: 150,
              fit: BoxFit.contain,
            ),
          ),
        const SizedBox(height: 32),

        // Action Buttons
        if (exercise.type == ExerciseType.reading)
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Implement audio recording
            },
            icon: const Icon(Icons.mic, color: Colors.white),
            label: const Text(
              'Grabar Audio',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          )
        else if (exercise.type == ExerciseType.writing)
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Implement take picture
            },
            icon: const Icon(Icons.camera_alt, color: Colors.white),
            label: const Text(
              'Tomar Foto',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
      ],
    );
  }
}
