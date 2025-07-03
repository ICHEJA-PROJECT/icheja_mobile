import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomFlottieImage extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  const CustomFlottieImage(
      {super.key,
      required this.imagePath,
      this.width = 50.0,
      this.height = 50.0});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      imagePath,
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }
}
