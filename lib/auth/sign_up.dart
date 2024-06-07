import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textspeech/auth/controller/sign_up_controller.dart';
import 'package:textspeech/interface/mobile/register_mobile_screen.dart';
import 'package:textspeech/interface/tablet/register_tablet_screen.dart';
import 'package:textspeech/util/etc/responsive.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Scaffold(
        body: isMobile(context)
            ? RegisterMobileScreen(controller: controller)
            : RegisterTabletScreen(controller: controller));
  }
}
