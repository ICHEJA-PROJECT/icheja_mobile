import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icheja_mobile/common/presentation/layouts/app_layout.dart';
import 'package:icheja_mobile/core/application/dependency_injection.dart';
import 'package:icheja_mobile/core/router/domain/constants/app_routes_constant.dart';
import 'package:icheja_mobile/exercises/presentation/viewmodels/exercise_viewmodel.dart';
import 'package:icheja_mobile/exercises/presentation/widgets/exercise_view.dart';
import 'package:provider/provider.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  late final ExerciseViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = sl<ExerciseViewModel>();
    _viewModel.addListener(_onViewModelChanged);
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChanged);
    super.dispose();
  }

  void _onViewModelChanged() {
    if (_viewModel.evaluatedFeedback != null) {
      final exercise = _viewModel.currentExercise;
      final feedback = _viewModel.evaluatedFeedback;

      if (exercise != null && feedback != null) {
        context.go(AppRoutesConstant.feedback, extra: {
          'exercise': exercise,
          'feedback': feedback,
        });
        _viewModel.clearFeedback();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: const AppLayout(
        body: ExerciseView(),
      ),
    );
  }
}
