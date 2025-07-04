import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';
import 'package:icheja_mobile/exercises/domain/entities/memorama_entity.dart';
import 'package:icheja_mobile/exercises/presentation/viewmodels/memorama_viewmodel.dart';
import 'package:icheja_mobile/exercises/presentation/widgets/memorama_card_widget.dart';

class MemoramaWidget extends StatelessWidget {
  final MemoramaExercise exercise;
  final MemoramaViewModel viewModel;

  const MemoramaWidget({
    super.key,
    required this.exercise,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
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

        // Grid de cartas
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.8,
              ),
              itemCount: viewModel.cards.length,
              itemBuilder: (context, index) {
                return MemoramaCardWidget(
                  card: viewModel.cards[index],
                  onTap: () => viewModel.selectCard(index),
                );
              },
            ),
          ),
        ),

        // Botón de reiniciar
        if (viewModel.gameCompleted)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: viewModel.resetGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorTheme.secondary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
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
          ),
      ],
    );
  }
}
