import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';
import 'package:icheja_mobile/exercises/domain/entities/exercise.dart';

class ExerciseLayout extends StatelessWidget {
  final Exercise exercise;
  final List<Widget> childrens;
  final bool isSpeaking;
  final VoidCallback onSpeakerPressed;

  const ExerciseLayout({
    super.key,
    required this.exercise,
    required this.childrens,
    required this.isSpeaking,
    required this.onSpeakerPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Ejercicio',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
              ),
              const SizedBox(width: 16),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                decoration: BoxDecoration(
                  color: ColorTheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${exercise.id}',
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: ColorTheme.text),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Content
          Text(
            exercise.instrucciones,
            textAlign: TextAlign.justify,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 26),

          // Instructions
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorTheme.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon:
                      Icon(isSpeaking ? Icons.stop : Icons.volume_up_outlined),
                  color: ColorTheme.text,
                  iconSize: 32,
                  onPressed: onSpeakerPressed,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'Instrucciones del ejercicio',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          ...childrens,
        ],
      ),
    );
  }
}
