import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textspeech/controllers/question_controller.dart';
import 'package:textspeech/firebase/loading_status.dart';
import 'package:textspeech/quiz/answer_card.dart';
import 'package:textspeech/quiz/app_bar_quiz.dart';
import 'package:textspeech/quiz/quiz_overview_screen.dart';
import 'package:textspeech/quiz/timer_screen.dart';
import 'package:textspeech/util/etc/app_colors.dart';

class QuestionScreen extends GetView<QuestionController> {
  const QuestionScreen({super.key});

  static const String routeName = '/questionscreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return Column(
            children: [
              AppBarQuizz(
                leading: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(left: 8.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
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
                const Expanded(child: CircularProgressIndicator()),
              if (controller.loadingStatus.value == LoadingStatus.completed)
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(
                      left: 24.0, right: 24.0, bottom: 24.0),
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
                                    controller
                                        .selectedAnswer(answer.identifier);
                                  },
                                  answer:
                                      '${answer.identifier}. ${answer.answer}',
                                  isSelected: answer.identifier ==
                                      controller.currentQuestion.value!
                                          .selectedAnswer,
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 10,
                                  ),
                              itemCount: controller
                                  .currentQuestion.value!.answers.length);
                        },
                      ),
                      const Spacer(),
                      SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              Visibility(
                                visible: controller.isFirstQuestion,
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
                                        child: const Icon(
                                          Icons.arrow_back_ios,
                                          color: kDark,
                                        )),
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
                                            ? Get.toNamed(
                                                TestOverviewScreen.routeName)
                                            : controller.nextQuestion();
                                      },
                                      child: Text(
                                        controller.isLastQuestion
                                            ? 'Complete'
                                            : 'Next',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      )),
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ))
            ],
          );
        }),
      ),
    );
  }
}
