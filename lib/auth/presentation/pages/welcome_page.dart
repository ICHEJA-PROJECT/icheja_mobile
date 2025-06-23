import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icheja_mobile/auth/presentation/layouts/auth_layout.dart';
import 'package:icheja_mobile/auth/presentation/viewmodels/welcome_viewmodel.dart';
import 'package:icheja_mobile/common/domain/constants/ui_constants.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';
import 'package:icheja_mobile/core/application/dependency_injection.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => sl<WelcomeViewmodel>(),
      child: const _WelcomePageBody(),
    );
  }
}

class _WelcomePageBody extends StatefulWidget {
  const _WelcomePageBody({super.key});

  @override
  State<_WelcomePageBody> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<_WelcomePageBody> {
  @override
  void initState() {
    super.initState();
    final viewModel = context.read<WelcomeViewmodel>();
    if (viewModel.isSpeaking) {
      viewModel.stop();
    } else {
      viewModel.speak(UIConstants.welcomeMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      childrens: [
        const Spacer(flex: 1),
        Image.asset(
          'assets/img/home_img.png',
          height: 270,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 30),
        const Text(
          'Bienvenido',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Pulsa iniciar sesión para abrir la camara y escanear el código QR',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
          ),
        ),
        const Spacer(flex: 1),
        ElevatedButton(
          onPressed: () {
            context.push('/qr_scanner');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorTheme.primary,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Iniciar sesión',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
