import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:textspeech/util/constants.dart';
import 'package:textspeech/util/quizzez_util/question_controller.dart';

class Option extends StatefulWidget {
  const Option({
    Key? key,
    required this.text,
    required this.index,
    required this.press,
  }) : super(key: key);

  final String text;
  final int index;
  final VoidCallback press;

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  final Debouncer debouncer =
      Debouncer(delay: const Duration(milliseconds: 500));
  late AudioPlayer player;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Perform UI update when option is tapped
        debouncer(
          () {
            setState(() {
              widget.press();
              playAudio();
            });
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          border: Border.all(color: getTheRightColor()),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${widget.index + 1}. ${widget.text}",
              style: TextStyle(color: getTheRightColor(), fontSize: 16),
            ),
            Container(
              height: 26,
              width: 26,
              decoration: BoxDecoration(
                color: getTheRightColor() == const Color(0xFFC1C1C1)
                    ? Colors.transparent
                    : getTheRightColor(),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: getTheRightColor()),
              ),
              child: getTheRightColor() == const Color(0xFFC1C1C1)
                  ? null
                  : Icon(getTheRightIcon(), size: 16),
            )
          ],
        ),
      ),
    );
  }

  void playAudio() {
    final qnController = Get.find<QuestionController>();
    if (qnController.isAnswered) {
      if (widget.index == qnController.correctAns) {
        player.play(AssetSource('voices/Correct_2.mp3'));
      } else if (widget.index == qnController.selectedAns &&
          qnController.selectedAns != qnController.correctAns) {
        player.play(AssetSource('voices/wrong.mp3'));
      }
    }
  }

  Color getTheRightColor() {
    final qnController = Get.find<QuestionController>();
    if (qnController.isAnswered) {
      if (widget.index == qnController.correctAns) {
        return kGreen;
      } else if (widget.index == qnController.selectedAns &&
          qnController.selectedAns != qnController.correctAns) {
        return const Color(0xFFE92E30);
      }
    }
    return const Color(0xFFC1C1C1);
  }

  IconData getTheRightIcon() {
    return getTheRightColor() == const Color(0xFFE92E30)
        ? Icons.close
        : Icons.done;
  }
}
