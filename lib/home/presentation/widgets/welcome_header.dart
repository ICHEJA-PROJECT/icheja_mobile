import 'package:flutter/material.dart';

class WelcomeHeader extends StatelessWidget {
  final String name;
  const WelcomeHeader({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundColor: Color(0xFFE0E0E0),
          child: Icon(Icons.person, color: Colors.black54),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            'Bienvenido $name',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const Icon(Icons.settings_outlined),
      ],
    );
  }
}
