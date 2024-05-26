import 'package:flutter/material.dart';
import 'package:textspeech/interface/game/mobile/quiz_mobile_screen.dart';
import 'package:textspeech/interface/game/tablet/quizz_tablet_screen.dart';
import 'package:textspeech/util/etc/responsive.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isMobile(context)
            ? const QuizMobileScreen()
            : const QuizTabletScreen());
  }
}
