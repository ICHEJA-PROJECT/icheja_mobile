import 'package:flutter/material.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Color(0xFFE0E0E0),
          child: Icon(Icons.person, color: Colors.black54),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Text(
            'Bienvenido Fernando',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Icon(Icons.settings_outlined),
      ],
    );
  }
}
