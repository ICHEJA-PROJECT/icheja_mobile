import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';

class GoBackButton extends StatelessWidget {
  final double width;
  final double height;
  final double iconSize;
  final String route;

  const GoBackButton(
      {super.key,
      required this.route,
      this.width = 0.06,
      this.height = 0.06,
      this.iconSize = 0.08});

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
            Size(size.width * width, size.height * height)),
        alignment: Alignment.center,
        padding: WidgetStateProperty.all(EdgeInsets.zero),
      ),
      child: Icon(
        Icons.arrow_back_sharp,
        color: ColorTheme.background,
        size: size.width * iconSize,
      ),
      onPressed: () {
        context.go(route);
      },
    );
  }
}
