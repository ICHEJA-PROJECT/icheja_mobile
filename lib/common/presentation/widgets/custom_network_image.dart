import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final double width;
  final double height;
  final String imageUrl;
  final Widget placeHolderImage;
  final Widget errorImage;
  final BoxFit fit;
  const CustomNetworkImage(
      {super.key,
      required this.imageUrl,
      required this.placeHolderImage,
      required this.errorImage,
      this.width = 50.0,
      this.height = 50.0,
      this.fit = BoxFit.contain});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      matchTextDirection: true,
      errorBuilder: (context, error, stackTrace) {
        return errorImage;
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return placeHolderImage;
      },
    );
  }
}
