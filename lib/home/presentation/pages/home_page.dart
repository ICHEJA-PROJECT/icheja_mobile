// ignore_for_file: unused_import, duplicate_import

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icheja_mobile/common/domain/constants/ui_constants.dart';
import 'package:icheja_mobile/common/presentation/layouts/app_layout.dart';
import 'package:icheja_mobile/common/presentation/layouts/horizontal_modal_layout.dart';
import 'package:icheja_mobile/common/presentation/layouts/modal_layout.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';
import 'package:icheja_mobile/common/presentation/widgets/modal_content.dart';
import 'package:icheja_mobile/common/presentation/widgets/modal_footer_actions.dart';
import 'package:icheja_mobile/common/presentation/widgets/modal_header.dart';
import 'package:icheja_mobile/core/application/dependency_injection.dart';
import 'package:icheja_mobile/core/router/domain/constants/app_routes_constant.dart';
import 'package:icheja_mobile/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:icheja_mobile/home/presentation/widgets/home_skeleton.dart';
import 'package:icheja_mobile/home/presentation/widgets/row_types.dart';
import 'package:icheja_mobile/home/presentation/widgets/welcome_header.dart';
import 'package:icheja_mobile/common/presentation/widgets/custom_network_image.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _modalShown = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_modalShown) {
        _showModal(context);
        _modalShown = true;
      }
    });
  }

  void _showModal(BuildContext context) {
    ModalLayout.show(
      context: context,
      header: const ModalHeader(
        title: "Recomendación",
        titleFontSize: 30,
        subtitleFontSize: 20,
        titleColor: ColorTheme.greenColor,
        subtitle: "Ejercicios recomendados",
      ),
      content: ModalContent(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HorizontalModalLayout(
              color: ColorTheme.primary,
              title: "¡De Señas a Letras: Descifra el Alfabeto!",
              textColor: ColorTheme.text,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              action: () {
                context.go('${AppRoutesConstant.exercises}/Abecedario/2');
              },
            ),
            const SizedBox(height: 20),
            HorizontalModalLayout(
              color: ColorTheme.primary,
              title: "¡De Señas a Letras: Descifra el Alfabeto!",
              textColor: ColorTheme.text,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '4',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              action: () {
                context.go('${AppRoutesConstant.exercises}/Abecedario/3');
              },
            ),
            const SizedBox(height: 20),
            HorizontalModalLayout(
              color: ColorTheme.primary,
              title: "Aprendiendo que cada seña tiene su letra",
              textColor: ColorTheme.text,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '7',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              action: () {
                context.go('${AppRoutesConstant.exercises}/Abecedario/6');
              },
            ),
          ],
        ),
      ),
      footerActions: ModalFooterActions(
        buttonTypes: const [ModalButtonType.close],
        onClose: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                      itemCount: viewModel.resourcesList.length,
                      itemBuilder: (context, index) {
                        final resource = viewModel.resourcesList[index];
                        return Column(
                          children: [
                            RowTypes(
                              text: resource.name,
                              overlayColor: resource.name ==
                                      UIConstants.all_resources
                                  ? ColorTheme.primary.withValues(alpha: 0.5)
                                  : ColorTheme.tertiary.withValues(alpha: 0.2),
                              backgroundColor:
                                  resource.name == UIConstants.all_resources
                                      ? ColorTheme.tertiary
                                      : ColorTheme.secondary,
                              imageUrl: resource.imageUrl,
                              onPressed: () {
                                context.go(
                                  '${AppRoutesConstant.resources}/${resource.name}',
                                );
                              },
                            ),
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
