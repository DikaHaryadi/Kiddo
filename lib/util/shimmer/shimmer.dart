import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DShimmerEffect extends StatelessWidget {
  final double width, height, radius;
  final Color? color;
  final BoxShape boxShape;
  const DShimmerEffect(
      {super.key,
      required this.width,
      required this.height,
      this.radius = 15,
      this.color,
      this.boxShape = BoxShape.rectangle});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: boxShape,
          borderRadius: boxShape == BoxShape.rectangle
              ? BorderRadius.circular(radius)
              : null,
          color: color ?? Colors.white,
        ),
      ),
    );
  }
}
