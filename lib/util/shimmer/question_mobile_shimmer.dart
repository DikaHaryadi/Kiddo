import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textspeech/util/shimmer/shimmer.dart';

class QuestionMobileShimmer extends StatelessWidget {
  const QuestionMobileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DShimmerEffect(
          width: Get.width / 2,
          height: 25,
          radius: 10.0,
        ),
        const SizedBox(height: 10.0),
        DShimmerEffect(
          width: Get.width / 2.5,
          height: 25,
          radius: 10.0,
        ),
        const SizedBox(height: 15.0),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (_, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: DShimmerEffect(
                width: double.infinity,
                height: 40,
                radius: 10.0,
              ),
            );
          },
          separatorBuilder: (_, int index) {
            return const SizedBox(height: 20.0);
          },
        )
      ],
    );
  }
}
