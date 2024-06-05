import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:textspeech/quiz/question_paper_controller.dart';

import '../../../quiz/quiz_card.dart';
import '../../../util/shimmer/quiz_tablet_shimmer.dart';

class QuizTabletScreen extends GetView<QuestionPaperController> {
  const QuizTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final loading = controller.isLoadingLetter.value;
      if (loading) {
        return const QuizTabletShimmer();
      } else {
        return AnimationLimiter(
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 20.0),
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
