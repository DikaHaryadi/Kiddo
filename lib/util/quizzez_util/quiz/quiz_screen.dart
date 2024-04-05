import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textspeech/util/constants.dart';
import 'package:textspeech/util/quizzez_util/question_controller.dart';
import 'package:textspeech/util/quizzez_util/quiz/components/progress_bar.dart';
import 'package:textspeech/util/quizzez_util/quiz/components/question_card.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuestionController _questionController = Get.put(QuestionController());
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          // Fluttter show the back button automatically
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            ElevatedButton(
                onPressed: _questionController.nextQuestion,
                child: Text("Skip")),
          ],
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ProgressBar(),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Obx(
                  () => Text.rich(
                    TextSpan(
                      text:
                          "Question ${_questionController.questionNumber.value}",
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: kSoftblue),
                      children: [
                        TextSpan(
                          text: "/${_questionController.questions.length}",
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
              Divider(thickness: 1.5),
              SizedBox(height: 20.0),
              Expanded(
                child: PageView.builder(
                  // Block swipe to next qn
                  physics: NeverScrollableScrollPhysics(),
                  controller: _questionController.pageController,
                  onPageChanged: _questionController.updateTheQnNum,
                  itemCount: _questionController.questions.length,
                  itemBuilder: (context, index) => QuestionCard(
                      question: _questionController.questions[index]),
                ),
              ),
            ],
          ),
        ));
  }
}
