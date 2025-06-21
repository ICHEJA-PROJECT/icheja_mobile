import 'package:flutter/material.dart';
import 'package:icheja_mobile/home/domain/entities/progress_entity.dart';
import 'package:icheja_mobile/home/presentation/widgets/custom_progress_bar.dart';

class ProgressCard extends StatelessWidget {
  final ProgressEntity progress;

  const ProgressCard({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  progress.title,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Icon(progress.icon, color: Colors.grey[700]),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Text(
                  '${progress.percentage}%',
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                const Text(
                  'completado',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 30,
              width: double.infinity,
              child: CustomProgressBar(
                value: progress.percentage / 100,
                color: progress.color,
                height: 15,
              ),
            )
          ],
        ),
      ),
    );
  }
}
