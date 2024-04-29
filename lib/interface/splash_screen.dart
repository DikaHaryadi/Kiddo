import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textspeech/util/auth_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dapatkan instance dari AuthController
    AuthController authController = Get.find();

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Image.asset(
          "assets/images/Logo_color1.png",
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
