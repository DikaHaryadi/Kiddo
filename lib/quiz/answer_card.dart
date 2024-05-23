import 'package:flutter/material.dart';
import 'package:textspeech/util/etc/app_colors.dart';

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
    return Material(
      color: Colors.transparent, // Make the Material widget transparent
      child: InkWell(
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
      ),
    );
  }
}
