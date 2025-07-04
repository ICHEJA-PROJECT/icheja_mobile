import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icheja_mobile/core/router/domain/constants/app_routes_constant.dart';

class WelcomeHeader extends StatelessWidget {
  final String name;
  final VoidCallback? onClickButtonFromExercise;
  const WelcomeHeader(
      {super.key, required this.name, this.onClickButtonFromExercise});

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
            flex: 1,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xFFE0E0E0),
              child: Icon(
                Icons.person,
                color: Colors.black54,
                size: 40,
              ),
            )),
        const Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 6,
          child: Text(
            'Bienvenido $name',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 1,
          child: location.startsWith(AppRoutesConstant.exercises)
              ? ElevatedButton(
                  onPressed: onClickButtonFromExercise ?? () {},
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(0.2),
                    backgroundColor: const Color(0xFFFFEC45),
                    shadowColor: Colors.transparent,
                  ),
                  child: Image.asset(
                    'assets/img/lightbulb.png',
                    scale: 3,
                  ))
              : IconButton(
                  onPressed: () {}, icon: const Icon(Icons.settings_outlined)),
        )
        // const Icon(Icons.settings_outlined),
      ],
    );
  }
}
