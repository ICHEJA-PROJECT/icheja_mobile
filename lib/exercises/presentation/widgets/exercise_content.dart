import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icheja_mobile/common/domain/constants/ui_constants.dart';
import 'package:icheja_mobile/common/presentation/layouts/modal_layout.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';
import 'package:icheja_mobile/common/presentation/widgets/custom_container_border.dart';
import 'package:icheja_mobile/common/presentation/widgets/custom_flottie_image.dart';
import 'package:icheja_mobile/common/presentation/widgets/custom_svg_network_image.dart';
import 'package:icheja_mobile/common/presentation/widgets/modal_content.dart';
import 'package:icheja_mobile/common/presentation/widgets/modal_footer_actions.dart';
import 'package:icheja_mobile/common/presentation/widgets/modal_header.dart';
import 'package:icheja_mobile/core/router/domain/constants/app_routes_constant.dart';
import 'package:icheja_mobile/exercises/domain/entities/context_entity.dart';
import 'package:icheja_mobile/exercises/domain/entities/exercise.dart';
import 'package:icheja_mobile/exercises/presentation/layouts/exercise_layout.dart';
import 'package:icheja_mobile/exercises/presentation/viewmodels/exercise_viewmodel.dart';
import 'package:icheja_mobile/exercises/presentation/widgets/correlation_exercise.dart';
import 'package:icheja_mobile/exercises/presentation/widgets/writing_exercise_actions.dart';

class ExerciseContent extends StatelessWidget {
  final String fieldNameSelected;
  final ExerciseViewModel viewModel;
  final bool isText;
  final bool isSelection;
  final Exercise exercise;

  const ExerciseContent({
    super.key,
    required this.exercise,
    required this.viewModel,
    this.isText = false,
    this.isSelection = false,
    required this.fieldNameSelected,
  });

  void _showGamificationModal(BuildContext context) {
    ModalLayout.show(
      context: context,
      barrierDismissible: true,
      header: ModalHeader(
        title: viewModel.exerciseMock?.retroalimentacion["titulo"] ??
            "¡Excelente!",
        titleFontSize: 30,
        subtitleFontSize: 20,
        titleColor: ColorTheme.greenColor,
        subtitle: viewModel.exerciseMock?.retroalimentacion["subtitulo"] ??
            "¡Has completado el ejercicio!",
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
          Navigator.of(context).pop(),
          context.go('${AppRoutesConstant.resources}/$fieldNameSelected')
        },
        onClose: () => {
          Navigator.of(context).pop(),
          context.go('${AppRoutesConstant.resources}/$fieldNameSelected')
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ExerciseLayout(
      fieldNameSelected: fieldNameSelected,
      exercise: exercise,
      isSpeaking: viewModel.isSpeaking,
      onSpeakerPressed: () {
        if (viewModel.isSpeaking) {
          viewModel.stop();
        } else {
          final typeExercise = exercise.type;
          final exerciseMessage = typeExercise == ExerciseType.writing
              ? UIConstants.writingMessage
              : UIConstants.readingMessage;
          viewModel.speak("$exerciseMessage ${exercise.instrucciones}");
        }
      },
      childrens: [
        if (isText) ...[
          const SizedBox(height: 16),
          CustomContainerBorder(
            borderColor: ColorTheme.primary,
            borderWidth: 10.0,
            borderRadius: 20.0,
            containerHeight: size.height * 0.30,
            item: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomSvgNetworkImage(
                  imageUrl: viewModel.exerciseMock?.contexto["imagen"] ??
                      'https://res.cloudinary.com/dsiamqhuu/image/upload/v1751572924/ICHEJA/ICHEJA/T2_R1_1.svg',
                  width: size.width * 0.30,
                  height: size.height * 0.30,
                  errorImage: const Icon(Icons.error, size: 50.0),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          WritingExerciseActions(
              viewModel: viewModel,
              onSendExercise: () {
                _showGamificationModal(context);
              }),
        ] else if (isSelection)
          ...[          CorrelationExerciseWidget(
              exerciseCtx: exercise.contexto as CorrelationContext,
              imagesPath: exercise.rutasImagenes,
              viewModel: viewModel)]

        // ? For future use, if needed
        // ExerciseMediaDisplay(
        //   exercise: exercise,
        //   viewModel: viewModel,
        // ),
        // const SizedBox(height: 32),
        // ExerciseActionButtons(
        //   exercise: exercise,
        //   viewModel: viewModel,
        // ),
      ],
    );
  }
}
