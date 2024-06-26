import 'package:flutter/material.dart';
import 'package:textspeech/quiz/answer_card.dart';
import 'package:textspeech/util/etc/app_colors.dart';

class QuestionNumberCard extends StatelessWidget {
  const QuestionNumberCard(
      {super.key,
      required this.index,
      required this.status,
      required this.onTap});

  final int index;
  final AnswerStatus? status;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.blueAccent;
    switch (status) {
      case AnswerStatus.answered:
        bgColor;
        break;
      case AnswerStatus.correct:
        bgColor = kGreen;
        break;
      case AnswerStatus.wrong:
        bgColor = Colors.red;
        break;
      case AnswerStatus.notanswered:
        bgColor = kGrey;
        break;

      default:
        bgColor = Theme.of(context).primaryColor.withOpacity(0.1);
    }
    return InkWell(
      borderRadius: BorderRadius.circular(15.0),
      onTap: onTap,
      child: Material(
        color: Colors.transparent,
        child: Ink(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: bgColor, borderRadius: BorderRadius.circular(15.0)),
          child: Center(
            child: Text(
              '$index',
              style: Theme.of(context).textTheme.bodyMedium?.apply(
                  color: status == AnswerStatus.notanswered ? kPrimary : null),
            ),
          ),
        ),
      ),
    );
  }
}
