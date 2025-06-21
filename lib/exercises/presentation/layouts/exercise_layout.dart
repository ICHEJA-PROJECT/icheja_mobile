import 'package:flutter/material.dart';
import 'package:icheja_mobile/exercises/domain/entities/exercise.dart';

class ExerciseLayout extends StatelessWidget {
  final Exercise exercise;
  final List<Widget> childrens;
  final VoidCallback onSend;
  final bool isSpeaking;
  final VoidCallback onSpeakerPressed;

  const ExerciseLayout({
    super.key,
    required this.exercise,
    required this.childrens,
    required this.onSend,
    required this.isSpeaking,
    required this.onSpeakerPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Image.asset('assets/img/logo.png', width: 40, height: 40),
          const SizedBox(height: 24),

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
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${exercise.id}',
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Content
          Text(
            exercise.instrucciones,
            textAlign: TextAlign.justify,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),

          // Instructions
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(isSpeaking ? Icons.stop : Icons.volume_up),
                  color: Colors.teal,
                  iconSize: 32,
                  onPressed: onSpeakerPressed,
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    'Instrucciones del ejercicio',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          ...childrens,

          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onSend,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Enviar Ejercicio',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
