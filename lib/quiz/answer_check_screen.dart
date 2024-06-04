import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textspeech/controllers/question_controller.dart';
import 'package:textspeech/quiz/answer_card.dart';
import 'package:textspeech/quiz/app_bar_quiz.dart';
import 'package:textspeech/quiz/result_screen.dart';

class AnswereCheckScreen extends GetView<QuestionController> {
  const AnswereCheckScreen({super.key});

  static const String routeName = '/anwerecheckscreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBarQuizz(
              controller: controller,
              titleWidget: Obx(() => Text(
                    'Number${(controller.questionIndex.value + 1).toString().padLeft(2, "0")}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  )),
              showActionIcon: true,
              onMenuActionTap: () {
                Get.toNamed(ResultQuizScreen.routeName);
              },
            ),
            Obx(() => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        Text(
                          controller.currentQuestion.value!.question,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16.0),
                        GetBuilder<QuestionController>(
                          id: 'answer_review_list',
                          builder: (_) {
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller
                                  .currentQuestion.value!.answers.length,
                              separatorBuilder: (_, index) {
                                return const SizedBox(height: 10.0);
                              },
                              itemBuilder: (_, index) {
                                final answer = controller
                                    .currentQuestion.value!.answers[index];
                                final selectedAnswer = controller
                                    .currentQuestion.value!.selectedAnswer;
                                final correctAnswer = controller
                                    .currentQuestion.value!.correctAnswer;
                                final String answerText =
                                    '${answer.identifier}. ${answer.answer}';

                                if (correctAnswer == selectedAnswer &&
                                    answer.identifier == selectedAnswer) {
                                  return CorrectAnswer(answer: answerText);
                                } else if (selectedAnswer == null) {
                                  return NotAnswered(answer: answerText);
                                } else if (selectedAnswer != correctAnswer &&
                                    answer.identifier == selectedAnswer) {
                                  return WrongAnswer(answer: answerText);
                                } else if (correctAnswer == answer.identifier) {
                                  return CorrectAnswer(answer: answerText);
                                }
                                return AnswerCard(
                                  answer: answerText,
                                  onTap: () {},
                                  isSelected: false,
                                );
                              },
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
