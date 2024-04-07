import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textspeech/util/constants.dart';
import 'package:textspeech/util/quizzez_util/question_controller.dart';
import 'package:textspeech/util/quizzez_util/question_model.dart';
import 'package:textspeech/util/quizzez_util/quiz/components/progress_bar.dart';
import 'package:textspeech/util/quizzez_util/quiz/components/question_card.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Question> questionSet = Get.arguments;

    QuestionController questionController = Get.put(QuestionController());

    // Inisialisasi QuestionController
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      questionController.init(questionSet.length);
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          ElevatedButton(
            onPressed: questionController.nextQuestion,
            child: const Text("Skip"),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ProgressBar(),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Obx(
                () => Text.rich(
                  TextSpan(
                    text:
                        "Question ${questionController.currentQuestionNumber.value}",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: kSoftblue),
                    children: [
                      TextSpan(
                        text: "/${questionSet.length}",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: kSoftblue),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(thickness: 1.5),
            const SizedBox(height: 20.0),
            Expanded(
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: questionController.pageController,
                onPageChanged: (index) =>
                    questionController.updateTheQnNum(index + 1),
                itemCount: questionSet.length,
                itemBuilder: (context, index) {
                  final currentQuestion = questionSet[index];
                  return QuestionCard(
                    controller: questionController,
                    question: currentQuestion,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
