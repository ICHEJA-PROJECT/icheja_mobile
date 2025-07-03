import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icheja_mobile/core/router/domain/constants/app_routes_constant.dart';
import 'package:icheja_mobile/home/presentation/widgets/home_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:icheja_mobile/common/presentation/layouts/app_layout.dart';
import 'package:icheja_mobile/core/application/dependency_injection.dart';
import 'package:icheja_mobile/exercises/presentation/viewmodels/exercise_viewmodel.dart';
import 'package:icheja_mobile/exercises/presentation/widgets/exercise_view.dart';
import 'package:icheja_mobile/home/presentation/widgets/welcome_header.dart';

class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => sl<ExerciseViewModel>(),
      child: AppLayout(
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Consumer<ExerciseViewModel>(
                builder: (context, viewmodel, child) {
              if (viewmodel.isLoading) {
                return const HomeSkeleton();
              }

              if (viewmodel.errorMessage != null) {
                return Center(child: Text('Error: ${viewmodel.errorMessage}'));
              }
              return Column(
                children: [
                  WelcomeHeader(
                    name: viewmodel.username ?? 'Usuario',
                    onClickButtonFromExercise: () {
                      context.go(AppRoutesConstant.resources);
                    },
                  ),
                  const SizedBox(height: 20.0),
                  const ExerciseView(),
                ],
              );
            })),
      ),
    );
  }
}
