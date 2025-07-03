import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageSkeletonLoader extends StatelessWidget {
  final double width;
  final double height;
  final Color baseColor;
  final Color highlightColor;

  ImageSkeletonLoader({
    super.key,
    this.width = double.infinity,
    this.height = 100.0,
    Color? baseColor,
    Color? highlightColor,
  })  : baseColor = baseColor ?? Colors.grey[300]!,
        highlightColor = highlightColor ?? Colors.grey[100]!;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
      ),
    );
  }
}
