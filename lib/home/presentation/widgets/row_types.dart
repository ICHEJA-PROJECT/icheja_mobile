import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';
import 'package:icheja_mobile/common/presentation/widgets/custom_network_image.dart';

class RowTypes extends StatelessWidget {
  final String text;
  final Color overlayColor;
  final Color backgroundColor;
  final String imageUrl;
  final VoidCallback? onPressed;

  const RowTypes(
      {super.key,
      required this.text,
      required this.overlayColor,
      required this.backgroundColor,
      required this.imageUrl,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ElevatedButton(
      style: ButtonStyle(
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(
                horizontal: size.width * 0.05, vertical: size.height * 0.02),
          ),
          overlayColor: WidgetStateProperty.all(
            overlayColor,
          ),
          minimumSize: WidgetStateProperty.all(
              Size(size.width * 0.9, size.height * 0.13)),
          elevation: WidgetStateProperty.all(4),
          backgroundColor: WidgetStateProperty.all(backgroundColor),
          shadowColor: WidgetStateProperty.all(ColorTheme.shadowColor),
          foregroundColor: WidgetStateProperty.all(ColorTheme.text),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          )),
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 7,
            child: Text(
              text,
              overflow: TextOverflow.clip,
              style: const TextStyle(
                fontSize: 27.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 18.0),
          Expanded(
            flex: 3,
            child: CustomNetworkImage(
              imageUrl: imageUrl,
              placeHolderImage: const CircularProgressIndicator(),
              errorImage: const Icon(Icons.error, size: 50.0),
              width: 50.0,
              height: 50.0,
            ),
          ),
        ],
      ),
    );
  }
}
