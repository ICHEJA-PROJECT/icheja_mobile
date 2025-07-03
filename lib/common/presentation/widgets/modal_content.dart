import 'package:flutter/material.dart';

class ModalContent extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const ModalContent({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
        child: child,
      ),
    );
  }
} 