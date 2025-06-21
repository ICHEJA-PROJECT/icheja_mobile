import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icheja_mobile/exercises/domain/entities/exercise.dart';
import 'package:icheja_mobile/exercises/presentation/pages/exercise_page.dart';
import 'package:icheja_mobile/feedback/presentation/pages/feedback_page.dart';
import 'package:icheja_mobile/home/presentation/pages/home_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  initialLocation: '/home',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/exercises',
      builder: (context, state) => const ExercisePage(),
    ),
    GoRoute(
      path: '/feedback',
      builder: (context, state) {
        final exercise = state.extra as Exercise;
        return FeedbackPage(exercise: exercise);
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) {
        return const Scaffold(
          body: Center(child: Text('Profile Page')),
        );
      },
    ),
  ],
);
