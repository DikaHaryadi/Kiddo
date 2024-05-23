import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textspeech/auth/controller/auth_controller.dart';
import 'package:textspeech/controllers/question_controller.dart';
import 'package:textspeech/firebase/loading_status.dart';
import 'package:textspeech/quiz/answer_card.dart';
import 'package:textspeech/util/etc/app_colors.dart';
import 'package:textspeech/util/etc/curved_edges.dart';

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
              ClipPath(
                clipper: TCustomCurvedEdges(),
                child: Container(
                  color: Colors.blueAccent,
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 100,
                              height: 30,
                              color: kError,
                            ),
                            GestureDetector(
                              onTap: () =>
                                  AuthenticationRepository.instance.logOut(),
                              child: Container(
                                width: 100,
                                height: 30,
                                decoration: BoxDecoration(
                                    border: Border.all(color: kWhite),
                                    borderRadius: BorderRadius.circular(2.0)),
                                child: Center(
                                  child: Text(
                                    'LOGOUT',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.apply(color: kWhite),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Get.toNamed('/edit-profile'),
                              child: Container(
                                width: 100,
                                height: 30,
                                decoration: BoxDecoration(
                                    border: Border.all(color: kWhite),
                                    borderRadius: BorderRadius.circular(2.0)),
                                child: Center(
                                  child: Text(
                                    'EDIT PROFILE',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.apply(color: kWhite),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
                                        child:
                                            const Icon(Icons.arrow_back_ios)),
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
                                            ? print(
                                                'Print ke halaman score berhasil')
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
