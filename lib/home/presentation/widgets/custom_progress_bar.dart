import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final double value;
  final Color color;
  final double height;

  const CustomProgressBar({
    super.key,
    required this.value,
    required this.color,
    this.height = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Container(
              width: constraints.maxWidth,
              height: height,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(height / 2),
              ),
            ),
            Container(
              width: constraints.maxWidth * value,
              height: height,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(height / 2),
              ),
            ),
            Positioned(
              top: -1,
              left: (constraints.maxWidth * value) - (height),
              child: Container(
                width: height * 1.8,
                height: height * 1.8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
