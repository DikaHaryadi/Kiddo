import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textspeech/interface/game/mobile/quiz_mobile_screen.dart';
import 'package:textspeech/interface/game/tablet/quizz_tablet_screen.dart';
import 'package:textspeech/util/etc/responsive.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: isMobile(context)
            ? AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                leading: IconButton(
                    onPressed: () => Get.toNamed('/home'),
                    icon: const Icon(Icons.arrow_back_ios)))
            : AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                leading: IconButton(
                    padding: const EdgeInsets.only(left: 25.0),
                    onPressed: () => Get.toNamed('/home'),
                    icon: const Icon(Icons.arrow_back_ios))),
        body: isMobile(context)
            ? const QuizMobileScreen()
            : const QuizTabletScreen());
  }
}
