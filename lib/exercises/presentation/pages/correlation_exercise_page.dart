import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icheja_mobile/common/presentation/layouts/app_layout.dart';
import 'package:icheja_mobile/common/presentation/layouts/modal_layout.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';
import 'package:icheja_mobile/common/presentation/widgets/image_decoration_container.dart';
import 'package:icheja_mobile/common/presentation/widgets/modal_content.dart';
import 'package:icheja_mobile/common/presentation/widgets/modal_footer_actions.dart';
import 'package:icheja_mobile/common/presentation/widgets/modal_header.dart';
import 'package:icheja_mobile/core/application/dependency_injection.dart';
import 'package:icheja_mobile/core/router/domain/constants/app_routes_constant.dart';
import 'package:icheja_mobile/exercises/presentation/viewmodels/correlation_exercise_viewmodel.dart';
import 'package:icheja_mobile/exercises/presentation/widgets/correlation_exercise.dart';
import 'package:icheja_mobile/home/presentation/widgets/home_skeleton.dart';
import 'package:icheja_mobile/home/presentation/widgets/welcome_header.dart';
import 'package:provider/provider.dart';

class CorrelationExercisePage extends StatefulWidget {
  const CorrelationExercisePage({super.key});

  @override
  State<CorrelationExercisePage> createState() =>
      _CorrelationExercisePageState();
}

class _CorrelationExercisePageState extends State<CorrelationExercisePage> {
  bool _modalShown = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_modalShown) {
        _showInstructionsModal(context);
        _modalShown = true;
      }
    });
  }

  void _showInstructionsModal(BuildContext context) {
    ModalLayout.show(
      context: context,
      barrierDismissible: true,
      header: const ModalHeader(
        title: "Instrucciones",
        titleFontSize: 30,
        subtitleFontSize: 20,
        titleColor: ColorTheme.goldColor,
        subtitle:
            "Observa la seña mostrada y selecciona la letra que corresponde",
      ),
      content: const ModalContent(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageDecorationContainer(
              imageUrl: 'https://media.tenor.com/HdXY24H0RaAAAAAM/haha-yay.gif',
              height: 200,
              width: 250,
              borderRadius: 15.0,
            )
          ],
        ),
      ),
      footerActions: ModalFooterActions(
        buttonTypes: const [ModalButtonType.next],
        onNext: () => {_modalShown = false, Navigator.of(context).pop()},
      ),
    ).then((_) {
      _modalShown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => sl<CorrelationExerciseViewModel>(),
      child: AppLayout(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<CorrelationExerciseViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.isLoading) {
                return const HomeSkeleton();
              }

              if (viewModel.errorMessage != null) {
                return Center(child: Text('Error: ${viewModel.errorMessage}'));
              }

              return Column(
                children: [
                  WelcomeHeader(
                    name: viewModel.username ?? 'Usuario',
                    onClickButtonFromExercise: () {
                      if (!_modalShown) {
                        _showInstructionsModal(context);
                        _modalShown = true;
                      }
                    },
                  ),
                  const SizedBox(height: 20.0),
                  if (viewModel.currentExercise != null)
                    CorrelationExerciseWidget(
                      exercise: viewModel.currentExercise!,
                      viewModel: viewModel,
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
