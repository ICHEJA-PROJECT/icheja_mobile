// lib/exercises/presentation/widgets/exercise_view.dart
import 'package:flutter/material.dart';
import 'package:icheja_mobile/exercises/presentation/viewmodels/exercise_viewmodel.dart';
import 'package:icheja_mobile/exercises/presentation/widgets/exercise_content.dart';
import 'package:icheja_mobile/exercises/presentation/widgets/exercise_skeleton.dart';
import 'package:provider/provider.dart';

class ExerciseView extends StatelessWidget {
  final String? topicName; // Parámetro opcional para el nombre del tema
  
  const ExerciseView({
    super.key,
    this.topicName,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ExerciseViewModel>(context, listen: true);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (viewModel.isExerciseLoading) // Cambiar isLoading por isExerciseLoading
          const Flexible(
            child: ExerciseSkeleton(),
          )
        else if (viewModel.errorMessage != null)
          Flexible(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    viewModel.errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Recargar el ejercicio si hay un topicName disponible
                      if (topicName != null) {
                        viewModel.loadExercise(topicName!, 0);
                      }
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            ),
          )
        else if (viewModel.exerciseMock != null) // Cambiar currentExercise por exerciseMock
          Flexible(
            child: ExerciseContent(
              viewModel: viewModel,
              exercise: viewModel.exerciseMock!, // PASAR EL EJERCICIO REQUERIDO
              fieldNameSelected: topicName ?? 'Ejercicio', // PASAR EL NOMBRE DEL TEMA
              isWriting: viewModel.exerciseMock?.escritura ?? false, // Determinar si es escritura
            ),
          )
        else
          const Flexible(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.assignment_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No se encontró ningún ejercicio.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}