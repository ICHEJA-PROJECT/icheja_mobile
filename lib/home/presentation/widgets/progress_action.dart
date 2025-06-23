import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';
import 'package:icheja_mobile/home/presentation/viewmodels/home_viewmodel.dart';

class ProgressAction extends StatefulWidget {
  final HomeViewModel viewModel;

  const ProgressAction({super.key, required this.viewModel});

  @override
  State<ProgressAction> createState() =>
      _ProgressActionState(viewModel: viewModel);
}

class _ProgressActionState extends State<ProgressAction> {
  final HomeViewModel viewModel;
  _ProgressActionState({required this.viewModel});
  @override
  void initState() {
    super.initState();
    if (viewModel.isSpeaking) {
      viewModel.stopSpeaking();
    } else {
      viewModel.speakProgress();
    }
  }

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
              viewModel.isSpeaking ? Icons.stop : Icons.volume_up_outlined,
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
