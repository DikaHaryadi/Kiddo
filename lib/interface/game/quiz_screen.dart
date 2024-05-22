import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:textspeech/quiz/question_paper_controller.dart';
import 'package:textspeech/quiz/quiz_card.dart';
import 'package:textspeech/util/etc/responsive.dart';
import 'package:textspeech/util/shimmer/content_shimmer.dart';
import 'package:textspeech/util/shimmer/quiz_tablet_shimmer.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QuestionPaperController());

    return Scaffold(
      body: SingleChildScrollView(
          child: isMobile(context)
              ? Obx(() {
                  final loading = controller.isLoadingLetter.value;
                  if (loading) {
                    return const ContentShimmer();
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
                                          model:
                                              controller.allPapers[index]))));
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 20);
                        },
                        itemCount: controller.allPapers.length,
                      ),
                    );
                  }
                })
              : Obx(() {
                  final loading = controller.isLoadingLetter.value;
                  if (loading) {
                    return const QuizTabletShimmer();
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
                                          model:
                                              controller.allPapers[index]))));
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 20);
                        },
                        itemCount: controller.allPapers.length,
                      ),
                    );
                  }
                })),
    );
  }
}
