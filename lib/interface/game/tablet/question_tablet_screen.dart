import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textspeech/quiz/app_bar_quiz.dart';
import 'package:textspeech/quiz/question_number.dart';
import 'package:textspeech/util/shimmer/question_tablet_shimmer.dart';

import '../../../controllers/question_controller.dart';
import '../../../firebase/loading_status.dart';
import '../../../quiz/answer_card.dart';
import '../../../quiz/timer_screen.dart';
import '../../../util/etc/app_colors.dart';

class QuestionTabletScreen extends StatelessWidget {
  final QuestionController controller;
  const QuestionTabletScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          AppBarQuizz(
            controller: controller,
            leading: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 20.0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: const ShapeDecoration(
                    shape: StadiumBorder(
                        side: BorderSide(color: kWhite, width: 2))),
                child: Obx(() => TimerScreen(time: controller.time.value)),
              ),
            ),
            showActionIcon: true,
            titleWidget: Obx(
              () => Text(
                'Number: ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.apply(color: kWhite),
              ),
            ),
          ),
          if (controller.loadingStatus.value == LoadingStatus.loading)
            const Expanded(child: QuestionTabletShimmer()),
          if (controller.loadingStatus.value == LoadingStatus.completed)
            Expanded(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 32.0),
              child: Column(
                children: [
                  Text(
                    controller.currentQuestion.value!.question,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.normal),
                  ),
                  GetBuilder<QuestionController>(
                    id: 'answers_list',
                    builder: (controller) {
                      return ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 25.0),
                          itemBuilder: (context, index) {
                            final answer = controller
                                .currentQuestion.value!.answers[index];
                            return AnswerCard(
                              onTap: () {
                                controller.selectedAnswer(answer.identifier);
                              },
                              answer: '${answer.identifier}. ${answer.answer}',
                              isSelected: answer.identifier ==
                                  controller
                                      .currentQuestion.value!.selectedAnswer,
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 25.0,
                              ),
                          itemCount:
                              controller.currentQuestion.value!.answers.length);
                    },
                  ),
                  const Spacer(),
                  SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Visibility(
                            visible: controller.isFirstQuestion,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: ElevatedButton(
                                  onPressed: () => controller.prevQuestion(),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: kSoftblue,
                                    side: const BorderSide(
                                        color: kError, width: 1),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_back_ios,
                                    color: kDark,
                                  )),
                            ),
                          ),
                          Expanded(
                            child: Visibility(
                              visible: controller.loadingStatus.value ==
                                  LoadingStatus.completed,
                              child: ElevatedButton(
                                  onPressed: () {
                                    controller.isLastQuestion
                                        ? showModalBottomSheet(
                                            enableDrag: true,
                                            useSafeArea: true,
                                            clipBehavior: Clip.hardEdge,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20),
                                              ),
                                            ),
                                            context: context,
                                            isScrollControlled: true,
                                            builder: (context) {
                                              controller.bottomSheetContext =
                                                  context;
                                              return DraggableScrollableSheet(
                                                expand: false,
                                                initialChildSize: 0.5,
                                                snap: true,
                                                snapSizes: const [0.5, 1.0],
                                                builder: (_, scrollController) {
                                                  return CustomScrollView(
                                                    controller:
                                                        scrollController,
                                                    physics:
                                                        const ClampingScrollPhysics(),
                                                    slivers: [
                                                      SliverToBoxAdapter(
                                                          child: Obx(() => Text(
                                                              '${controller.time} Remaining'))),
                                                      SliverGrid(
                                                        delegate:
                                                            SliverChildBuilderDelegate(
                                                          (_, index) {
                                                            AnswerStatus?
                                                                _answereStatus;
                                                            if (controller
                                                                    .allQuestions[
                                                                        index]
                                                                    .selectedAnswer !=
                                                                null) {
                                                              _answereStatus =
                                                                  AnswerStatus
                                                                      .answered;
                                                            }
                                                            return QuestionNumberCard(
                                                                index:
                                                                    index + 1,
                                                                status:
                                                                    _answereStatus,
                                                                onTap: () => controller
                                                                    .jumpToQuestion(
                                                                        index));
                                                          },
                                                          childCount: controller
                                                              .allQuestions
                                                              .length,
                                                        ),
                                                        gridDelegate:
                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount:
                                                              (Get.width ~/ 75),
                                                          childAspectRatio: 1,
                                                          crossAxisSpacing: 8,
                                                          mainAxisSpacing: 8,
                                                        ),
                                                      ),
                                                      SliverToBoxAdapter(
                                                          child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 24.0,
                                                                left: 24.0,
                                                                right: 24.0),
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  Get.width / 3,
                                                              child:
                                                                  OutlinedButton(
                                                                      onPressed:
                                                                          controller
                                                                              .navigateToHome,
                                                                      child:
                                                                          const Text(
                                                                        'Keluar',
                                                                      )),
                                                            ),
                                                            const SizedBox(
                                                                width: 8.0),
                                                            Expanded(
                                                              child: SizedBox(
                                                                  width: double
                                                                      .infinity,
                                                                  child: ElevatedButton(
                                                                      onPressed: controller.complete,
                                                                      child: const Text(
                                                                        'Complete',
                                                                      ))),
                                                            ),
                                                          ],
                                                        ),
                                                      ))
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                          )
                                        : controller.nextQuestion();
                                  },
                                  child: Text(
                                    controller.isLastQuestion
                                        ? 'Complete'
                                        : 'Next Question',
                                  )),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ))
        ],
      ),
    );
  }
}
