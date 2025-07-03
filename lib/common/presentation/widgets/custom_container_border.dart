import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';

class CustomContainerBorder extends StatelessWidget {
  final Color borderColor;
  final Color containerColor;
  final double borderWidth;
  final double containerHeight;
  final double borderRadius;
  final Widget item;

  const CustomContainerBorder(
      {super.key,
      this.borderColor = ColorTheme.secondary,
      this.borderWidth = 4.0,
      this.containerHeight = 100.0,
      this.containerColor = Colors.white,
      this.borderRadius = 15.0,
      required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: containerHeight,
        decoration: BoxDecoration(
          color: containerColor,
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: const [
            BoxShadow(
              color: ColorTheme.shadowColor,
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        margin: const EdgeInsets.all(5.0),
        child: Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 5.0),
            child: item));
  }
}
