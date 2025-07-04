import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';
import 'package:icheja_mobile/common/presentation/widgets/go_back_button.dart';
import 'package:icheja_mobile/core/router/domain/constants/app_routes_constant.dart';
import 'package:icheja_mobile/exercises/domain/entities/exercise.dart';

class ExerciseLayout extends StatelessWidget {
  final Exercise exercise;
  final List<Widget> childrens;
  final bool isSpeaking;
  final VoidCallback onSpeakerPressed;
  final bool isDeaf;

  const ExerciseLayout({
    super.key,
    required this.exercise,
    required this.childrens,
    required this.isSpeaking,
    required this.onSpeakerPressed,
    this.isDeaf = true,
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
              const GoBackButton(
                route: AppRoutesConstant.resources,
                width: 0.03,
                height: 0.06,
                iconSize: 0.07,
              ),
              const SizedBox(width: 16),
              const Text(
                'Ejercicio',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 16),

              // ? Exercise ID
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
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
              const SizedBox(width: 60),
              if (!isDeaf) ...[
                Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: ColorTheme.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: Icon(
                        isSpeaking ? Icons.stop : Icons.volume_up_outlined),
                    color: ColorTheme.text,
                    iconSize: 30,
                    onPressed: onSpeakerPressed,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    'Instrucciones del ejercicio',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ]
            ],
          ),

          const SizedBox(height: 24),

          ...childrens,
        ],
      ),
    );
  }
}
