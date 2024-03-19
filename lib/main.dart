import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textspeech/interface/center_category.dart';
import 'package:textspeech/interface/game_ui.dart';
import 'package:textspeech/interface/homepage.dart';
import 'package:textspeech/interface/numbers_game.dart';
import 'package:textspeech/interface/onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      // getPages: [
      //   GetPage(name: '/', page: () => const HomePage()),
      //   GetPage(name: '/memo-game', page: () => const StartUpPage()),
      //   GetPage(name: '/numbers-game', page: () => const NumbersGame()),
      //   GetPage(name: '/categories', page: () => const CategoryCenter()),
      // ]
      home: OnboardingPage(),
    );
  }
}
