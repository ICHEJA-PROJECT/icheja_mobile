import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvgNetworkImage extends StatelessWidget {
  final double width;
  final double height;
  final String imageUrl;
  final Widget errorImage;
  final BoxFit fit;
  const CustomSvgNetworkImage(
      {super.key,
      required this.imageUrl,
      required this.errorImage,
      this.width = 50.0,
      this.height = 50.0,
      this.fit = BoxFit.contain});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      matchTextDirection: true,
      errorBuilder: (context, error, stackTrace) {
        return errorImage;
      },
    );
  }
}
