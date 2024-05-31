import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DShimmerEffect(
                height: Get.width * 0.2,
                width: Get.width * 0.2,
              ),
              const SizedBox(width: 25.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DShimmerEffect(
                      width: Get.width / 4,
                      height: 50,
                      radius: 10.0,
                    ),
                    const SizedBox(height: 10.0),
                    DShimmerEffect(
                      width: Get.width / 2.5,
                      height: 50,
                      radius: 10.0,
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        DShimmerEffect(
                          width: Get.width / 2,
                          height: 50,
                          radius: 10.0,
                        ),
                        const Expanded(child: SizedBox.shrink()),
                        const DShimmerEffect(
                          width: 60,
                          height: 60,
                          radius: 10.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
