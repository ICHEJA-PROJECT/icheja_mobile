import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icheja_mobile/auth/presentation/layouts/auth_layout.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

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
