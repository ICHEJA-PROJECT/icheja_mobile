import 'package:flutter/widgets.dart';

class ContentText extends StatelessWidget {
  const ContentText({super.key, required this.title, this.child, this.textColor});
  final Widget? child;
  final String? title;
  final Color? textColor;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (child != null) child!,
          if (child != null) const SizedBox(width: 8),
          Flexible(
            child: Text(
              title ?? '',
              style: TextStyle(
                fontSize: 24,
                color: textColor,
                fontWeight: FontWeight.w900,
              ),
              textAlign: child != null ? TextAlign.left : TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}