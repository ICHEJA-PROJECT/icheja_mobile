import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icheja_mobile/auth/presentation/pages/qr_scanner_page.dart';
import 'package:icheja_mobile/auth/presentation/pages/welcome_page.dart';
import 'package:icheja_mobile/core/application/dependency_injection.dart';
import 'package:icheja_mobile/core/router/domain/constants/app_routes_constant.dart';
import 'package:icheja_mobile/core/session/session_manager.dart';
import 'package:icheja_mobile/exercises/domain/entities/exercise.dart';
import 'package:icheja_mobile/exercises/domain/entities/feedback_entity.dart';
import 'package:icheja_mobile/exercises/presentation/pages/exercise_page.dart';
import 'package:icheja_mobile/feedback/presentation/pages/feedback_page.dart';
import 'package:icheja_mobile/home/presentation/pages/home_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  initialLocation: AppRoutesConstant.home,
  navigatorKey: _rootNavigatorKey,
  redirect: (BuildContext context, GoRouterState state) async {
    final routesNonSecure = [
      AppRoutesConstant.welcome,
      AppRoutesConstant.qrScanner,
    ];
    final sessionManager = sl<SessionManager>();
    final token = await sessionManager.getToken();
    final isLoggedIn = token != null;

    final isNonSecure = routesNonSecure.contains(state.matchedLocation);

    if (!isLoggedIn && !isNonSecure) {
      // Si no ha iniciado sesión y intenta acceder a una página no segura, redirigir a bienvenida
      return AppRoutesConstant.welcome;
    }

    if (isLoggedIn && isNonSecure) {
      // Si ya ha iniciado sesión y intenta acceder a una página no segura, redirigir a la página no segura
      return state.matchedLocation;
    }
    return null;
  },
  routes: [
    GoRoute(
      path: AppRoutesConstant.welcome,
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: AppRoutesConstant.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppRoutesConstant.qrScanner,
      builder: (context, state) => const QRScannerPage(),
    ),
    GoRoute(
      path: AppRoutesConstant.exercises,
      builder: (context, state) => const ExercisePage(),
    ),
    GoRoute(
      path: AppRoutesConstant.feedback,
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        final exercise = data['exercise'] as Exercise;
        final feedback = data['feedback'] as FeedbackEntity;
        return FeedbackPage(exercise: exercise, feedback: feedback);
      },
    ),
    GoRoute(
      path: AppRoutesConstant.profile,
      builder: (context, state) {
        return const Scaffold(
          body: Center(child: Text('Profile Page')),
        );
      },
    ),
  ],
);
