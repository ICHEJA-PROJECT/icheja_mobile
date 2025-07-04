import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/layouts/modal_layout.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';
import 'package:icheja_mobile/common/presentation/widgets/image_decoration_container.dart';
import 'package:icheja_mobile/common/presentation/widgets/modal_content.dart';
import 'package:icheja_mobile/common/presentation/widgets/modal_footer_actions.dart';
import 'package:icheja_mobile/common/presentation/widgets/modal_header.dart';
import 'package:icheja_mobile/home/presentation/widgets/home_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:icheja_mobile/common/presentation/layouts/app_layout.dart';
import 'package:icheja_mobile/exercises/presentation/viewmodels/exercise_viewmodel.dart';
import 'package:icheja_mobile/exercises/presentation/widgets/exercise_view.dart';
import 'package:icheja_mobile/home/presentation/widgets/welcome_header.dart';

class ExercisePage extends StatefulWidget {
  final String fieldNameSelected;
  const ExercisePage({super.key, required this.fieldNameSelected});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
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
    final viewModel = Provider.of<ExerciseViewModel>(context, listen: false);
    print(viewModel.exerciseMock);
    ModalLayout.show(
      context: context,
      barrierDismissible: true,
      header: ModalHeader(
        title: "Instrucciones",
        titleFontSize: 30,
        subtitleFontSize: 20,
        titleColor: ColorTheme.goldColor,
        subtitle: viewModel.exerciseMock?.instrucciones ??
            "Escribe la letra en papel",
      ),
      content: ModalContent(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageDecorationContainer(
              imageUrl: viewModel.exerciseMock?.mediaInstrucciones["media"] ??
                  'https://media.tenor.com/HdXY24H0RaAAAAAM/haha-yay.gif',
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
    return AppLayout(
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child:
              Consumer<ExerciseViewModel>(builder: (context, viewmodel, child) {
            if (viewmodel.isLoading) {
              return const HomeSkeleton();
            }

            if (viewmodel.isExerciseLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (viewmodel.errorMessage != null) {
              return Center(child: Text('Error: ${viewmodel.errorMessage}'));
            }

            if (viewmodel.exerciseMock == null) {
              return const Center(
                child: Text('No exercise data available'),
              );
            }
            return Column(
              children: [
                WelcomeHeader(
                  name: viewmodel.username ?? 'Usuario',
                  onClickButtonFromExercise: () {
                    if (!_modalShown) {
                      _showInstructionsModal(context);
                      _modalShown = true;
                    }
                  },
                ),
                const SizedBox(height: 20.0),
                ExerciseView(fieldNameSelected: widget.fieldNameSelected),
              ],
            );
          })),
    );
  }
}
