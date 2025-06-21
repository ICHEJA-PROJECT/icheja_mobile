import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';
import 'package:icheja_mobile/exercises/domain/entities/exercise.dart';
import 'package:icheja_mobile/exercises/presentation/viewmodels/exercise_viewmodel.dart';

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
      return _ReadingExerciseActions(viewModel: viewModel);
    } else if (exercise.type == ExerciseType.writing) {
      return _WritingExerciseActions(viewModel: viewModel);
    } else {
      return const SizedBox.shrink();
    }
  }
}

class _ReadingExerciseActions extends StatelessWidget {
  final ExerciseViewModel viewModel;

  const _ReadingExerciseActions({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Primary Action Button
        ElevatedButton.icon(
          onPressed: () {
            if (viewModel.isRecording) {
              viewModel.stopRecording();
            } else {
              viewModel.startRecording();
            }
          },
          icon: Icon(viewModel.isRecording ? Icons.stop : Icons.mic,
              color: Colors.white),
          label: Text(
            viewModel.isRecording ? 'Detener Grabación' : 'Grabar Audio',
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor:
                viewModel.isRecording ? Colors.red : ColorTheme.secondary,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        // Playback Button
        if (viewModel.recordedFilePath != null && !viewModel.isRecording)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: ElevatedButton.icon(
              onPressed: () {
                if (viewModel.isPlaying) {
                  viewModel.stopPlayback();
                } else {
                  viewModel.playRecording();
                }
              },
              icon: Icon(viewModel.isPlaying ? Icons.stop : Icons.play_arrow,
                  color: Colors.white),
              label: Text(
                viewModel.isPlaying
                    ? 'Detener Reproducción'
                    : 'Reproducir Audio',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[700],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
            ),
          ),

        const SizedBox(height: 16),
        // Send Button
        ElevatedButton(
          onPressed: () {
            if (viewModel.currentExercise != null) {
              context.go('/feedback', extra: viewModel.currentExercise);
            }
          },
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

class _WritingExerciseActions extends StatelessWidget {
  final ExerciseViewModel viewModel;

  const _WritingExerciseActions({required this.viewModel});

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
          onPressed: () {
            if (viewModel.currentExercise != null) {
              context.go('/feedback', extra: viewModel.currentExercise);
            }
          },
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
