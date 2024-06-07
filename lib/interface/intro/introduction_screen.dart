import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textspeech/auth/controller/introduction_controller.dart';
import 'package:textspeech/interface/mobile/login_mobile_screen.dart';
import 'package:textspeech/interface/tablet/login_tablet_screen.dart';
import 'package:textspeech/util/etc/responsive.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(IntroductionController());
    return Scaffold(
        body: isMobile(context)
            ? LoginMobileScreen(controller: controller)
            : LoginTabletScreen(controller: controller));
  }
}
