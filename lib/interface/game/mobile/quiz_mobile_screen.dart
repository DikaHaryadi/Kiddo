import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:textspeech/quiz/question_paper_controller.dart';

import '../../../quiz/quiz_card.dart';
import '../../../util/shimmer/content_shimmer.dart';

class QuizMobileScreen extends GetView<QuestionPaperController> {
  const QuizMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final loading = controller.isLoadingLetter.value;
      if (loading) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: ContentShimmer(),
        );
      } else {
        return AnimationLimiter(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                  position: index,
                  delay: const Duration(milliseconds: 250),
                  duration: const Duration(milliseconds: 1000),
                  child: SlideAnimation(
                      verticalOffset: 44.0,
                      child: FadeInAnimation(
                          child: QuestionCard(
                              model: controller.allPapers[index]))));
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 20);
            },
            itemCount: controller.allPapers.length,
          ),
        );
      }
    });
  }
}
