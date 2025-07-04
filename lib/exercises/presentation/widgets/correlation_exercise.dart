import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icheja_mobile/common/presentation/layouts/modal_layout.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';
import 'package:icheja_mobile/common/presentation/widgets/custom_flottie_image.dart';
import 'package:icheja_mobile/common/presentation/widgets/custom_svg_network_image.dart';
import 'package:icheja_mobile/common/presentation/widgets/modal_content.dart';
import 'package:icheja_mobile/common/presentation/widgets/modal_footer_actions.dart';
import 'package:icheja_mobile/common/presentation/widgets/modal_header.dart';
import 'package:icheja_mobile/core/router/domain/constants/app_routes_constant.dart';
import 'package:icheja_mobile/exercises/presentation/viewmodels/exercise_viewmodel.dart';
import 'package:icheja_mobile/exercises/presentation/widgets/exercise_image_display.dart';
import 'package:icheja_mobile/exercises/presentation/widgets/option_button.dart';

class CorrelationExerciseWidget extends StatelessWidget {
  final Map<String, dynamic> exerciseCtx;
  final List<String> imagesPath;
  final ExerciseViewModel viewModel;
  final String fieldNameSelected;

  const CorrelationExerciseWidget({
    super.key,
    required this.exerciseCtx,
    required this.imagesPath,
    required this.viewModel,
    required this.fieldNameSelected,
  });

  void _showSuccessModal(BuildContext context) {
    ModalLayout.show(
      context: context,
      barrierDismissible: true,
      header: const ModalHeader(
        title: "¡Felicidades!",
        titleFontSize: 30,
        subtitleFontSize: 20,
        titleColor: ColorTheme.greenColor,
        subtitle: "Sigue trabajando así",
      ),
      content: const ModalContent(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomFlottieImage(
              imagePath: 'assets/lotties/gamification.json',
              height: 120,
              width: 120,
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
      footerActions: ModalFooterActions(
        buttonTypes: const [ModalButtonType.close, ModalButtonType.next],
        onNext: () => {
          viewModel.resetFeedback(),
          Navigator.of(context).pop(),
          context.go('${AppRoutesConstant.resources}/$fieldNameSelected')
        },
        onClose: () => {
          viewModel.resetFeedback(),
          Navigator.of(context).pop(),
          context.go('${AppRoutesConstant.resources}/$fieldNameSelected')
        },
      ),
    ).then(
      (_) {
        viewModel.resetFeedback();
        context.go('${AppRoutesConstant.resources}/$fieldNameSelected');
      },
    );
  }

  void _showTryAgainModal(BuildContext context) {
    ModalLayout.show(
      context: context,
      barrierDismissible: true,
      header: const ModalHeader(
        title: "¡Estás cerca!",
        titleFontSize: 30,
        subtitleFontSize: 20,
        titleColor: ColorTheme.primary,
        subtitle: "Inténtalo de nuevo",
      ),
      content: const ModalContent(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomFlottieImage(
              imagePath: 'assets/lotties/gamification.json',
              height: 120,
              width: 120,
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
      footerActions: ModalFooterActions(
        buttonTypes: const [ModalButtonType.close],
        onClose: () {
          viewModel.resetFeedback();
          Navigator.of(context).pop();
        },
      ),
    ).then(
      (_) {
        viewModel.resetFeedback();
      },
    );
  }

  void _handleOptionSelected(BuildContext context, int index) {
    viewModel.selectOption(index);
    if (viewModel.isCorrect) {
      _showSuccessModal(context);
    } else {
      _showTryAgainModal(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(imagesPath);
    return Column(
      children: [
        if (imagesPath.isNotEmpty) ...[
          const SizedBox(height: 16),
          Center(
            child: ExerciseImageDisplay(
              borderColor: ColorTheme.primary,
              size: size.width * 0.5,
              child: CustomSvgNetworkImage(
                imageUrl: imagesPath.first,
                width: size.width * 0.5,
                height: size.width * 0.5,
                errorImage: const Icon(Icons.error, size: 50.0),
              ),
            ),
          ),
        ],
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            exerciseCtx["opciones"].length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                width: 90,
                height: 90,
                child: OptionButton(
                  text: exerciseCtx["opciones"][index],
                  isSelected: viewModel.selectedOption == index,
                  onPressed: () => _handleOptionSelected(context, index),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
