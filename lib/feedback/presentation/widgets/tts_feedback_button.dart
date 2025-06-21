import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';
import 'package:icheja_mobile/feedback/presentation/viewmodels/feedback_viewmodel.dart';
import 'package:provider/provider.dart';

class TtsFeedbackButton extends StatelessWidget {
  final String text;
  const TtsFeedbackButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<FeedbackViewModel>(context);

    return GestureDetector(
      onTap: () {
        if (viewModel.isSpeaking) {
          viewModel.stop();
        } else {
          viewModel.speak(text);
        }
      },
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ColorTheme.secondary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              viewModel.isSpeaking ? Icons.stop : Icons.volume_up,
              color: ColorTheme.text,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'Retroalimentación',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
