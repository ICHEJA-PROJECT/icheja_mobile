import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/layouts/app_layout.dart';
import 'package:icheja_mobile/common/presentation/layouts/modal_layout.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';
import 'package:icheja_mobile/common/presentation/widgets/modal_content.dart';
import 'package:icheja_mobile/common/presentation/widgets/modal_footer_actions.dart';
import 'package:icheja_mobile/common/presentation/widgets/modal_header.dart';
import 'package:icheja_mobile/core/application/dependency_injection.dart';
import 'package:icheja_mobile/exercises/presentation/viewmodels/memorama_viewmodel.dart';
import 'package:icheja_mobile/exercises/presentation/widgets/memorama_widget.dart';
import 'package:icheja_mobile/home/presentation/widgets/home_skeleton.dart';
import 'package:icheja_mobile/home/presentation/widgets/welcome_header.dart';
import 'package:provider/provider.dart';

class MemoramaExercisePage extends StatefulWidget {
  const MemoramaExercisePage({super.key});

  @override
  State<MemoramaExercisePage> createState() => _MemoramaExercisePageState();
}

class _MemoramaExercisePageState extends State<MemoramaExercisePage> {
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
        title: "¡Memorama!",
        titleFontSize: 30,
        subtitleFontSize: 20,
        titleColor: ColorTheme.goldColor,
        subtitle: "Encuentra los pares de letras y señas",
      ),
      content: const ModalContent(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.memory,
              size: 80,
              color: ColorTheme.primary,
            ),
            SizedBox(height: 16),
            Text(
              "Voltea las cartas y encuentra las parejas que correspondan entre letras y señas.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
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
      create: (context) => sl<MemoramaViewModel>(),
      child: AppLayout(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<MemoramaViewModel>(
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: MemoramaWidget(
                        exercise: viewModel.currentExercise!,
                        viewModel: viewModel,
                      ),
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