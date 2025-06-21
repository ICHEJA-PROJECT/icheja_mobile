import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ExerciseSkeleton extends StatelessWidget {
  const ExerciseSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title Skeleton
            Row(
              children: [
                Container(
                  width: 120,
                  height: 24.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4)),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 50,
                  height: 30.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Content Skeleton
            for (var i = 0; i < 3; i++)
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                height: 16.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4)),
              ),
            const SizedBox(height: 26),

            // Instructions Skeleton
            Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    height: 20.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Media Display Skeleton
            Container(
              height: 200.0,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
            ),
            const SizedBox(height: 32),

            // Action Buttons Skeleton
            Container(
              height: 52.0,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
            ),

            const SizedBox(height: 16),
            // Send Button Skeleton
            Container(
              height: 52.0,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
            ),
          ],
        ),
      ),
    );
  }
}
