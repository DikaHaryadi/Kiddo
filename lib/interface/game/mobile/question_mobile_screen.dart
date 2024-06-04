import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textspeech/util/shimmer/question_mobile_shimmer.dart';

import '../../../controllers/question_controller.dart';
import '../../../firebase/loading_status.dart';
import '../../../quiz/answer_card.dart';
import '../../../quiz/app_bar_quiz.dart';
import '../../../quiz/question_number.dart';
import '../../../quiz/timer_screen.dart';
import '../../../util/etc/app_colors.dart';

class QuestionMobileScreen extends StatelessWidget {
  final QuestionController controller;
  const QuestionMobileScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          AppBarQuizz(
            leading: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 8.0),
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
            controller: controller,
          ),
          if (controller.loadingStatus.value == LoadingStatus.loading)
            const Expanded(child: QuestionMobileShimmer()),
          if (controller.loadingStatus.value == LoadingStatus.completed)
            Expanded(
                child: Padding(
              padding:
                  const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0),
              child: Column(
                children: [
                  Text(
                    controller.currentQuestion.value!.question,
                    style: Theme.of(context).textTheme.titleLarge,
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
                                height: 10,
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
                            child: Expanded(
                              child: SizedBox(
                                width: 56,
                                height: 56,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ElevatedButton(
                                      onPressed: () =>
                                          controller.prevQuestion(),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: kSoftblue,
                                        side: const BorderSide(
                                            color: kError, width: 1),
                                      ),
                                      child: Text(
                                        'Back',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      )),
                                ),
                              ),
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
                                            builder: (BuildContext context) {
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
                                                        child:
                                                            Obx(() => Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: Text(
                                                                      '${controller.time} Remuygfhhvgaining'),
                                                                )),
                                                      ),
                                                      SliverGrid(
                                                        delegate:
                                                            SliverChildBuilderDelegate(
                                                          (_, index) {
                                                            AnswerStatus?
                                                                _answerStatus;
                                                            if (controller
                                                                    .allQuestions[
                                                                        index]
                                                                    .selectedAnswer !=
                                                                null) {
                                                              _answerStatus =
                                                                  AnswerStatus
                                                                      .answered;
                                                            }
                                                            return QuestionNumberCard(
                                                              index: index + 1,
                                                              status:
                                                                  _answerStatus,
                                                              onTap: () => controller
                                                                  .jumpToQuestion(
                                                                      index),
                                                            );
                                                          },
                                                          childCount: controller
                                                              .allQuestions
                                                              .length,
                                                        ),
                                                        gridDelegate:
                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount:
                                                              (Get.width ~/ 50),
                                                          childAspectRatio: 1,
                                                          crossAxisSpacing: 8,
                                                          mainAxisSpacing: 8,
                                                        ),
                                                      ),
                                                      SliverToBoxAdapter(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                      24.0),
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                width:
                                                                    Get.width /
                                                                        3,
                                                                child:
                                                                    OutlinedButton(
                                                                  onPressed:
                                                                      controller
                                                                          .navigateToHome,
                                                                  child: const Text(
                                                                      'Keluar'),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 8.0),
                                                              Expanded(
                                                                child: SizedBox(
                                                                  width: double
                                                                      .infinity,
                                                                  child:
                                                                      ElevatedButton(
                                                                    onPressed:
                                                                        controller
                                                                            .complete,
                                                                    child: const Text(
                                                                        'Complete'),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
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
                                        : 'Next',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
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
