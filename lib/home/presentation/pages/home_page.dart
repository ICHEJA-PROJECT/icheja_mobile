import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icheja_mobile/common/presentation/layouts/app_layout.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';
import 'package:icheja_mobile/core/application/dependency_injection.dart';
import 'package:icheja_mobile/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:icheja_mobile/home/presentation/widgets/progress_action.dart';
import 'package:icheja_mobile/home/presentation/widgets/progress_card.dart';
import 'package:icheja_mobile/home/presentation/widgets/welcome_header.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => sl<HomeViewModel>(),
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return AppLayout(
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  const WelcomeHeader(),
                  const SizedBox(height: 25),
                  const ProgressAction(),
                  const SizedBox(height: 30),
                  if (viewModel.isLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (viewModel.error != null)
                    Center(child: Text('Error: ${viewModel.error}'))
                  else
                    ...viewModel.progressList
                        .map((progress) => ProgressCard(progress: progress)),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorTheme.tertiary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => context.go('/exercises'),
                    child: const Text(
                      'Iniciar ejercicio',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: ColorTheme.text,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
