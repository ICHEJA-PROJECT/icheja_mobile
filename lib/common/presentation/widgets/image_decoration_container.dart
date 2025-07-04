import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/widgets/custom_network_image.dart';
import 'package:icheja_mobile/common/presentation/widgets/image_skeleton_loader.dart';

class ImageDecorationContainer extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final double borderRadius;
  final BoxFit fit;

  const ImageDecorationContainer({
    super.key,
    required this.imageUrl,
    this.height = 100,
    this.width = double.infinity,
    this.borderRadius = 10.0,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CustomNetworkImage(
        imageUrl: imageUrl,
        placeHolderImage: ImageSkeletonLoader(
          width: width,
          height: height,
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
        ),
        errorImage: const Icon(Icons.error, size: 50.0),
        width: width,
        height: height,
        fit: fit,
      ),
    );
  }
}
