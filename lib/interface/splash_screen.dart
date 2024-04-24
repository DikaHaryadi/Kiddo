import 'package:flutter/material.dart';
import 'package:textspeech/util/config/themes/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(gradient: mainGradient(context)),
      child: Image.asset(
        "assets/images/Logo_color1.png",
        width: 200,
        height: 200,
      ),
    ));
  }
}
