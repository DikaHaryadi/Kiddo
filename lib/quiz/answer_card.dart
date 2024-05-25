import 'package:flutter/material.dart';
import 'package:textspeech/util/etc/app_colors.dart';

enum AnswerStatus { correct, wrong, answered, notanswered }

class AnswerCard extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final VoidCallback onTap;

  const AnswerCard({
    Key? key,
    required this.answer,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15.0),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: isSelected ? kGreen : kWhite,
          border: Border.all(color: isSelected ? kDark : kWhite),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: Text(
          answer,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isSelected ? kError : null,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
        ),
      ),
    );
  }
}

class CorrectAnswer extends StatelessWidget {
  const CorrectAnswer({super.key, required this.answer});

  final String answer;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: kGreen.withOpacity(0.1)),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Text(
        answer,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}

class WrongAnswer extends StatelessWidget {
  const WrongAnswer({super.key, required this.answer});

  final String answer;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: kError.withOpacity(0.1)),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Text(
        answer,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}

class NotAnswered extends StatelessWidget {
  const NotAnswered({super.key, required this.answer});

  final String answer;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: kGrey.withOpacity(0.1)),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Text(
        answer,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
