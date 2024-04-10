import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:textspeech/firebase_options.dart';
import 'package:textspeech/interface/content/animal.dart';
import 'package:textspeech/interface/content/family.dart';
import 'package:textspeech/interface/content/fruits.dart';
import 'package:textspeech/interface/content/letters.dart';
import 'package:textspeech/interface/content/numbers.dart';
import 'package:textspeech/interface/content/vegetables.dart';
import 'package:textspeech/interface/detail%20content/showall_content.dart';
import 'package:textspeech/interface/game_ui.dart';
import 'package:textspeech/interface/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:textspeech/quiz/data_uploader_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDateFormatting('en_US', null);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // debugShowCheckedModeBanner: false,
      // initialRoute: '/',
      // getPages: [
      //   GetPage(name: '/', page: () => const HomePage()),
      //   // Games
      //   GetPage(name: '/memo-game', page: () => const StartUpPage()),
      //   // Content
      //   GetPage(name: '/number-content', page: () => const NumberContent()),
      //   GetPage(name: '/letters-content', page: () => const LettersContent()),
      //   GetPage(name: '/animals-content', page: () => const AnimalContent()),
      //   GetPage(name: '/family-content', page: () => const FamilyContent()),
      //   GetPage(name: '/fruits-content', page: () => const FruitsContent()),
      //   GetPage(
      //       name: '/vegetables-content',
      //       page: () => const VegetablesContent()),
      //   // Quizez Component Route
      //   // show all content
      //   GetPage(
      //       name: '/show-all-content', page: () => const ShowAllContent()),
      // ]
      home: DataUploaderScreen(),
    );
  }
}
