import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textspeech/controllers/question_controller.dart';
import 'package:textspeech/controllers/question_controller_extension.dart';
import 'package:textspeech/quiz/answer_card.dart';
import 'package:textspeech/quiz/answer_check_screen.dart';
import 'package:textspeech/quiz/question_number.dart';
import 'package:textspeech/util/etc/curved_edges.dart';

class ResultQuizScreen extends GetView<QuestionController> {
  const ResultQuizScreen({super.key});

  static const String routeName = '/resultscreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          ClipPath(
            clipper: TCustomCurvedEdges(),
            child: Container(
                color: Colors.blueAccent,
                height: 100,
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Center(
                  child: Text(
                    controller.corrextAnsweredQuestion,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                )),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Image.asset('assets/images/logo.png'),
                  const SizedBox(height: 16.0),
                  Text('Congratulations'),
                  Text('You have ${controller.points} points'),
                  Expanded(
                    child: GridView.builder(
                      itemCount: controller.allQuestions.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: Get.width ~/ 75,
                          childAspectRatio: 1,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8),
                      itemBuilder: (_, index) {
                        final _question = controller.allQuestions[index];
                        AnswerStatus _status = AnswerStatus.notanswered;
                        final _selectedAnswer = _question.selectedAnswer;
                        final _correctAnswer = _question.correctAnswer;
                        if (_selectedAnswer == _correctAnswer) {
                          _status = AnswerStatus.correct;
                        } else if (_question.selectedAnswer == null) {
                          _status = AnswerStatus.wrong;
                        } else {
                          _status = AnswerStatus.wrong;
                        }
                        return QuestionNumberCard(
                          index: index + 1,
                          status: _status,
                          onTap: () {
                            controller.jumpToQuestion(index, isGoBack: false);
                            Get.toNamed(AnswereCheckScreen.routeName);
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () => Get.offAllNamed('/home'),
                            child: Text(
                              'Complete',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ))),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
