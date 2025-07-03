import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';

class GoBackButton extends StatelessWidget {
  final String route;

  const GoBackButton({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          ColorTheme.primary,
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        fixedSize: WidgetStateProperty.all(
            Size(size.width * 0.06, size.height * 0.06)),
        alignment: Alignment.center,
        padding: WidgetStateProperty.all(EdgeInsets.zero),
      ),
      child: Icon(
        Icons.arrow_back_sharp,
        color: ColorTheme.background,
        size: size.width * 0.08,
      ),
      onPressed: () {
        context.go(route);
      },
    );
  }
}
