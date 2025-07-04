import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icheja_mobile/common/presentation/layouts/app_layout.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';
import 'package:icheja_mobile/core/application/dependency_injection.dart';
import 'package:icheja_mobile/core/router/domain/constants/app_routes_constant.dart';
import 'package:icheja_mobile/exercises/domain/entities/exercise.dart';
import 'package:icheja_mobile/exercises/domain/entities/feedback_entity.dart';
import 'package:icheja_mobile/exercises/presentation/viewmodels/exercise_viewmodel.dart';
import 'package:icheja_mobile/feedback/presentation/viewmodels/feedback_viewmodel.dart';
import 'package:icheja_mobile/feedback/presentation/widgets/feedback_body.dart';
import 'package:provider/provider.dart';

class FeedbackPage extends StatelessWidget {
  final Exercise exercise;
  final FeedbackEntity feedback;

  const FeedbackPage({
    super.key,
    required this.exercise,
    required this.feedback,
  });

  @override
  Widget build(BuildContext context) {
    final exerciseViewModel = sl<ExerciseViewModel>();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: exerciseViewModel),
        ChangeNotifierProvider(create: (context) => sl<FeedbackViewModel>()),
      ],
      child: AppLayout(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: FeedbackBody(
                  exercise: exercise,
                  feedback: feedback,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // exerciseViewModel.nextExercise();
                    context.go(AppRoutesConstant.exercises);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorTheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Finalizar',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
