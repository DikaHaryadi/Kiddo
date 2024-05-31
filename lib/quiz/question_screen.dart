import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textspeech/controllers/question_controller.dart';
import 'package:textspeech/interface/game/mobile/question_mobile_screen.dart';
import 'package:textspeech/interface/game/tablet/question_tablet_screen.dart';
import 'package:textspeech/util/etc/responsive.dart';

class QuestionScreen extends GetView<QuestionController> {
  const QuestionScreen({super.key});

  static const String routeName = '/questionscreen';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
            child: isMobile(context)
                ? QuestionMobileScreen(controller: controller)
                : QuestionTabletScreen(controller: controller)),
      ),
    );
  }
}
