import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/layouts/app_layout.dart';
import 'package:icheja_mobile/common/presentation/layouts/modal_layout.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';
import 'package:icheja_mobile/common/presentation/widgets/modal_content.dart';
import 'package:icheja_mobile/common/presentation/widgets/modal_footer_actions.dart';
import 'package:icheja_mobile/common/presentation/widgets/modal_header.dart';
import 'package:icheja_mobile/core/application/dependency_injection.dart';
import 'package:icheja_mobile/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:icheja_mobile/home/presentation/widgets/home_skeleton.dart';
import 'package:icheja_mobile/home/presentation/widgets/row_types.dart';
import 'package:icheja_mobile/home/presentation/widgets/welcome_header.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showModal(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: ModalLayout(
            header: ModalHeader(
              title: title,
              titleColor: Colors.red,
              subtitle: "Ejemplo de subtitulo",
            ),
            content: ModalContent(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.school,
                    size: 64,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Ejemplpo de modal de $title",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            footerActions: ModalFooterActions(
              buttonTypes: [ModalButtonType.close, ModalButtonType.next],
              onClose: () => Navigator.of(context).pop(),
              onNext: () {
                Navigator.of(context).pop();
                print("Navegando a: $title");
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<String> allTexts = [
      'Temario global',
      'Caligrafía',
      'Abecedario',
      'Nombres propios',
      'Calendario'
    ];
    return ChangeNotifierProvider(
      create: (context) => sl<HomeViewModel>(),
      child: AppLayout(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Consumer<HomeViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.isLoading) {
                return const HomeSkeleton();
              }

              if (viewModel.error != null) {
                return Center(child: Text('Error: ${viewModel.error}'));
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  WelcomeHeader(name: viewModel.username ?? 'Usuario'),
                  const SizedBox(height: 25),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: allTexts.length,
                      itemBuilder: (context, index) {
                        final text = allTexts[index];
                        return Column(
                          children: [
                            RowTypes(
                                text: text,
                                overlayColor: text == 'Temario global'
                                    ? ColorTheme.primary.withValues(alpha: 0.5)
                                    : ColorTheme.tertiary
                                        .withValues(alpha: 0.2),
                                backgroundColor: text == 'Temario global'
                                    ? ColorTheme.tertiary
                                    : ColorTheme.secondary,
                                imageUrl:
                                    'https://cdn-icons-png.flaticon.com/512/8136/8136031.png',
                                onPressed: () => _showModal(context, text)),
                            const SizedBox(height: 25),
                          ],
                        );
                      }),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
