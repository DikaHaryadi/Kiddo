import 'package:flutter/material.dart';
import 'package:textspeech/util/constants.dart';
import 'package:textspeech/util/quizzez_util/question_controller.dart';
import 'package:textspeech/util/quizzez_util/question_model.dart';
import 'package:textspeech/util/quizzez_util/quiz/components/option.dart';

class QuestionCard extends StatelessWidget {
  final QuestionController controller;
  final Question question;

  const QuestionCard({
    Key? key,
    required this.controller,
    required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              press: () => controller.checkAns(question, index),
            ),
          ),
        ],
      ),
    );
  }
}
