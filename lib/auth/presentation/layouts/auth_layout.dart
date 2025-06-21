import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {
  final List<Widget> childrens;
  const AuthLayout({super.key, required this.childrens});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Image.asset(
              'assets/img/logo.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ...childrens,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
