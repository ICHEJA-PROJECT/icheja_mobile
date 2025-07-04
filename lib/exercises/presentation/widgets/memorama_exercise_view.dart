import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';
import 'package:icheja_mobile/exercises/presentation/viewmodels/exercise_viewmodel.dart';
import 'package:icheja_mobile/exercises/presentation/widgets/memorama_card_widget.dart';

class MemoramaExerciseView extends StatelessWidget {
  final ExerciseViewModel viewModel;

  const MemoramaExerciseView({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    // Verificar que existe el ejercicio y es de tipo memorama
    if (viewModel.exerciseMock == null || !viewModel.isCurrentExerciseMemory) {
      return const Center(
        child: Text(
          'No hay ejercicio de memorama disponible',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    final exercise = viewModel.exerciseMock!;

    return Column(
      children: [
        // Título del ejercicio
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            exercise.titulo,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ColorTheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        // Instrucciones
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            exercise.instrucciones,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),

        const SizedBox(height: 20),

        // Progreso del juego
        if (viewModel.memoramaCards.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.memory, color: ColorTheme.secondary),
                const SizedBox(width: 8),
                Text(
                  'Pares encontrados: ${viewModel.memoramaProgress}/${viewModel.totalMemoramaPairs}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: ColorTheme.secondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],

        // Grid de cartas
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: viewModel.memoramaCards.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(
                      color: ColorTheme.primary,
                    ),
                  )
                : GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: viewModel.memoramaCards.length,
                    itemBuilder: (context, index) {
                      return MemoramaCardWidget(
                        card: viewModel.memoramaCards[index],
                        onTap: () => viewModel.selectMemoramaCard(index),
                      );
                    },
                  ),
          ),
        ),

        // Mensaje de completado y botón de reiniciar
        if (viewModel.memoramaCompleted) ...[
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: ColorTheme.greenColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: ColorTheme.greenColor, width: 2),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.celebration,
                  size: 48,
                  color: ColorTheme.greenColor,
                ),
                const SizedBox(height: 8),
                const Text(
                  '¡Felicidades! Has completado el memorama',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorTheme.greenColor,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: viewModel.resetMemorama,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorTheme.secondary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    '¡Jugar de nuevo!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}