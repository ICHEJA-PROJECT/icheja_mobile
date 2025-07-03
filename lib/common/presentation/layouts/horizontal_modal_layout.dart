import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/widgets/horizontal_content_text.dart';

class HorizontalModalLayout extends StatelessWidget {
  final Color color;
  final String title;
  final Widget? child;
  final Color? textColor;
  final VoidCallback? action;

  const HorizontalModalLayout({
    super.key,
    required this.color,
    required this.title,
    this.child,
    this.textColor,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: ContentText(
          title: title,
          textColor: textColor,
          child: child,
        ),
      ),
    );
  }
}
