import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textspeech/controllers/question_controller.dart';
import 'package:textspeech/quiz/answer_card.dart';
import 'package:textspeech/quiz/app_bar_quiz.dart';
import 'package:textspeech/quiz/question_number.dart';
import 'package:textspeech/quiz/timer_screen.dart';
import 'package:textspeech/util/etc/app_colors.dart';
import 'package:textspeech/util/etc/responsive.dart';

class TestOverviewScreen extends GetView<QuestionController> {
  const TestOverviewScreen({super.key});

  static const String routeName = '/testoverview';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isMobile(context)
            ? Column(
                children: [
                  AppBarQuizz(
                    title: controller.completedTest,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const TimerScreen(
                                time: '',
                                color: kDark,
                              ),
                              Obx(() => Text('${controller.time} Remaining'))
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          Expanded(
                            child: GridView.builder(
                              itemCount: controller.allQuestions.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: Get.width ~/ 75,
                                      childAspectRatio: 1,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8),
                              itemBuilder: (_, index) {
                                AnswerStatus? _answereStatus;
                                if (controller
                                        .allQuestions[index].selectedAnswer !=
                                    null) {
                                  _answereStatus = AnswerStatus.answered;
                                }
                                return QuestionNumberCard(
                                    index: index + 1,
                                    status: _answereStatus,
                                    onTap: () =>
                                        controller.jumpToQuestion(index));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 24.0, left: 24.0, right: 24.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.width / 3,
                          child: OutlinedButton(
                              onPressed: controller.navigateToHome,
                              child: const Text(
                                'Keluar',
                              )),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: controller.complete,
                                  child: const Text(
                                    'Complete',
                                  ))),
                        ),
                      ],
                    ),
                  )
                ],
              )
            : Column(
                children: [
                  AppBarQuizz(
                    title: controller.completedTest,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const TimerScreen(
                                time: '',
                                color: kDark,
                              ),
                              Obx(() => Text('${controller.time} Remaining'))
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          Expanded(
                            child: GridView.builder(
                              itemCount: controller.allQuestions.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: Get.width ~/ 100,
                                      childAspectRatio: 1,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8),
                              itemBuilder: (_, index) {
                                AnswerStatus? _answereStatus;
                                if (controller
                                        .allQuestions[index].selectedAnswer !=
                                    null) {
                                  _answereStatus = AnswerStatus.answered;
                                }
                                return QuestionNumberCard(
                                    index: index + 1,
                                    status: _answereStatus,
                                    onTap: () =>
                                        controller.jumpToQuestion(index));
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 24.0),
                            child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: controller.complete,
                                    child: Text(
                                      'Complete',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ))),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 24.0, left: 24.0, right: 24.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.width / 3,
                          child: OutlinedButton(
                              onPressed: () => Get.offAllNamed('/home'),
                              child: const Text(
                                'Keluar',
                              )),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: controller.complete,
                                  child: const Text(
                                    'Complete',
                                  ))),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
