import 'package:get/get.dart';
import 'package:textspeech/interface/content/animal.dart';
import 'package:textspeech/interface/content/family.dart';
import 'package:textspeech/interface/content/fruits.dart';
import 'package:textspeech/interface/content/letters.dart';
import 'package:textspeech/interface/content/numbers.dart';
import 'package:textspeech/interface/content/vegetables.dart';
import 'package:textspeech/interface/detail%20content/showall_content.dart';
import 'package:textspeech/interface/game_ui.dart';
import 'package:textspeech/interface/homepage.dart';
import 'package:textspeech/interface/introduction_screen.dart';
import 'package:textspeech/interface/splash_screen.dart';
import 'package:textspeech/quiz/question_paper_controller.dart';
import 'package:textspeech/quiz/quiz_screen.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(
          name: '/home',
          page: () => const HomePage(),
        ),
        GetPage(name: '/introduction', page: () => const IntroductionScreen()),
        // Games
        GetPage(name: '/memo-game', page: () => const StartUpPage()),
        GetPage(
            name: '/main-menu-quiz',
            page: () => const QuizScreen(),
            binding: BindingsBuilder(() {
              Get.put(QuestionPaperController());
            })),
        // Content
        GetPage(name: '/number-content', page: () => const NumberContent()),
        GetPage(name: '/letters-content', page: () => const LettersContent()),
        GetPage(name: '/animals-content', page: () => const AnimalContent()),
        GetPage(name: '/family-content', page: () => const FamilyContent()),
        GetPage(name: '/fruits-content', page: () => const FruitsContent()),
        GetPage(
            name: '/vegetables-content', page: () => const VegetablesContent()),
        // Quizez Component Route
        // show all content
        GetPage(name: '/show-all-content', page: () => const ShowAllContent()),
      ];
}
