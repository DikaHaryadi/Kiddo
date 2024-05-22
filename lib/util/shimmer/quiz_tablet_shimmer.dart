import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textspeech/util/shimmer/shimmer.dart';

class QuizTabletShimmer extends StatelessWidget {
  const QuizTabletShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: DShimmerEffect(width: Get.width, height: Get.height * 0.15),
        );
      },
    );
  }
}
