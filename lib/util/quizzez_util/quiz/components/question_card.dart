import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:textspeech/util/constants.dart';
import 'package:textspeech/util/quizzez_util/question_controller.dart';
import 'package:textspeech/util/quizzez_util/question_model.dart';
import 'package:textspeech/util/quizzez_util/quiz/components/option.dart';

class QuestionCard extends StatelessWidget {
  final Question question;

  const QuestionCard({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    QuestionController controller = Get.put(QuestionController());

    final Debouncer debouncer = Debouncer(delay: const Duration(seconds: 1));
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(
            question.question,
            style:
                Theme.of(context).textTheme.headline6!.copyWith(color: kDark),
          ),
          const SizedBox(height: 20.0 / 2),
          ...List.generate(
            question.options.length,
            (index) => Option(
              index: index,
              text: question.options[index],
              press: () => debouncer(() {
                controller.checkAns(question, index);
              }),
            ),
          ),
        ],
      ),
    );
  }
}
