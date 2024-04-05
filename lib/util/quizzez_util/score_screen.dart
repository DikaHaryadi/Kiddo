import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textspeech/util/constants.dart';
import 'package:textspeech/util/quizzez_util/question_controller.dart';
import 'package:unicons/unicons.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionController qnController = Get.put(QuestionController());
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Score",
              style:
                  Theme.of(context).textTheme.headline3!.copyWith(color: kDark),
            ),
            const SizedBox(height: 20.0),
            Text(
              "${qnController.numOfCorrectAns * 10}/${qnController.questions.length * 10}",
              style:
                  Theme.of(context).textTheme.headline4!.copyWith(color: kDark),
            ),
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Get.offNamed('/main-menu-quiz');
                  },
                  icon: const Icon(UniconsLine.repeat),
                  label: const Text('Retry'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Get.offAllNamed('/');
                  },
                  icon: const Icon(UniconsLine.home),
                  label: const Text('Home'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
