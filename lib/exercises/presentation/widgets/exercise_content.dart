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
import 'package:icheja_mobile/exercises/presentation/layouts/exercise_layout.dart';
import 'package:icheja_mobile/exercises/presentation/viewmodels/exercise_viewmodel.dart';
import 'package:icheja_mobile/exercises/presentation/widgets/writing_exercise_actions.dart';
import 'package:icheja_mobile/exercises/presentation/widgets/memorama_exercise_view.dart';
import 'package:icheja_mobile/home/domain/entities/topic_content_entity.dart';

class ExerciseContent extends StatelessWidget {
  final ExerciseViewModel viewModel;
  final bool isWriting;
  final ExerciseEntity exercise; // Cambiar de Exercise a ExerciseEntity
  final String fieldNameSelected; // AGREGAR ESTE PARÁMETRO

  const ExerciseContent({
    super.key,
    required this.exercise,
    required this.viewModel,
    required this.fieldNameSelected, // AGREGAR ESTE PARÁMETRO
    this.isWriting = false,
  });

  void _showGamificationModal(BuildContext context) {
    ModalLayout.show(
      context: context,
      barrierDismissible: true,
      header: const ModalHeader(
        title: "Felicidades!!",
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
        onNext: () => {Navigator.of(context).pop()},
        onClose: () => {
          Navigator.of(context).pop(),
          context.go(AppRoutesConstant.resourceDetail)
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ExerciseLayout(
      exercise: exercise,
      isSpeaking: viewModel.isSpeaking,
      fieldNameSelected: fieldNameSelected, // AGREGAR ESTE PARÁMETRO
      onSpeakerPressed: () {
        if (viewModel.isSpeaking) {
          viewModel.stop();
        } else {
          String exerciseMessage;
          
          // Determinar el tipo de ejercicio basado en las propiedades booleanas
          if (exercise.memoria) {
            exerciseMessage = "En este ejercicio de memorama, deberás encontrar las parejas entre letras y señas. Voltea las cartas y memoriza su posición para formar todas las parejas posibles.";
          } else if (exercise.escritura) {
            exerciseMessage = UIConstants.writingMessage;
          } else if (exercise.lectura) {
            exerciseMessage = UIConstants.readingMessage;
          } else {
            exerciseMessage = "Sigue las instrucciones del ejercicio.";
          }
          
          viewModel.speak("$exerciseMessage ${exercise.instrucciones}");
        }
      },
      childrens: [
        // AGREGAR CONDICIÓN PARA MEMORAMA
        if (exercise.memoria) ...[
          SizedBox(
            height: size.height * 0.6,
            child: MemoramaExerciseView(viewModel: viewModel),
          ),
        ] else if (isWriting || exercise.escritura) ...[
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
                  imageUrl:
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
        ]
      ],
    );
  }
}