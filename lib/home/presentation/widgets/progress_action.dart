import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';
import 'package:icheja_mobile/home/presentation/viewmodels/home_viewmodel.dart';

class ProgressAction extends StatelessWidget {
  final HomeViewModel viewModel;
  const ProgressAction({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (viewModel.isSpeaking) {
          viewModel.stopSpeaking();
        } else {
          viewModel.speakProgress();
        }
      },
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ColorTheme.secondary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              viewModel.isSpeaking ? Icons.stop : Icons.volume_up,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'Escuchar tu progreso',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
