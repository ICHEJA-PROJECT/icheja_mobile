import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';
import 'package:icheja_mobile/exercises/domain/entities/context_entity.dart';
import 'package:icheja_mobile/exercises/domain/entities/exercise.dart';
import 'package:icheja_mobile/exercises/presentation/viewmodels/exercise_viewmodel.dart';
import 'package:provider/provider.dart';

class MediaComparisonDisplay extends StatelessWidget {
  final Exercise exercise;
  const MediaComparisonDisplay({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    // We need the viewmodel to get the user's taken picture
    final exerciseViewModel =
        Provider.of<ExerciseViewModel>(context, listen: false);
    final contextEntity = exercise.contexto;

    if (contextEntity is WritingContext) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Comparación',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const SizedBox(width: 16),
                // Original image
                Expanded(
                    child: _buildImagePlaceholder(contextEntity.imageBase)),
                const SizedBox(width: 16),
                // User's picture
                Expanded(
                  child: exerciseViewModel.takenPicture != null
                      ? Image.file(exerciseViewModel.takenPicture!)
                      : _buildImagePlaceholder(null),
                ),
              ],
            )
          ]);
    }

    return const SizedBox.shrink();
  }

  Widget _buildImagePlaceholder(String? imageUrl) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: ColorTheme.background,
          borderRadius: BorderRadius.circular(20),
        ),
        child: imageUrl != null
            ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
              )
            : const Icon(Icons.image_not_supported,
                color: Colors.grey, size: 40),
      ),
    );
  }
}
