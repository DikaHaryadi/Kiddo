import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:textspeech/interface/content/animal.dart';
import 'package:textspeech/interface/content/family.dart';
import 'package:textspeech/interface/content/fruits.dart';
import 'package:textspeech/interface/content/letters.dart';
import 'package:textspeech/interface/content/numbers.dart';
import 'package:textspeech/interface/content/vegetables.dart';
import 'package:textspeech/interface/game_ui.dart';
import 'package:textspeech/interface/homepage.dart';
import 'package:textspeech/interface/numbers_game.dart';
// import 'package:textspeech/interface/onboarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());
  await initializeDateFormatting('id', null);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => const HomePage()),
          // Games
          GetPage(name: '/memo-game', page: () => const StartUpPage()),
          GetPage(name: '/numbers-game', page: () => const NumbersGame()),
          // Content
          GetPage(name: '/number-content', page: () => const NumberContent()),
          GetPage(name: '/letters-content', page: () => const LettersContent()),
          GetPage(name: '/animals-content', page: () => const AnimalContent()),
          GetPage(name: '/family-content', page: () => const FamilyContent()),
          GetPage(name: '/fruits-content', page: () => const FruitsContent()),
          GetPage(
              name: '/vegetables-content',
              page: () => const VegetablesContent()),
        ]
        // home: FamilyContent(),
        );
  }
}
