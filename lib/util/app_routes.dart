import 'package:get/get.dart';
import 'package:textspeech/auth/controller/sign_up_controller.dart';
import 'package:textspeech/auth/controller/verify_email_controller.dart';
import 'package:textspeech/auth/forget_pw.dart';
import 'package:textspeech/auth/reset_password.dart';
import 'package:textspeech/auth/success_verify.dart';
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
import 'package:textspeech/auth/sign_up.dart';
import 'package:textspeech/interface/splash_screen.dart';
import 'package:textspeech/auth/verify_email.dart';
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
        GetPage(
            name: '/signup',
            page: () => const SignUpScreen(),
            binding: BindingsBuilder(() {
              Get.put(SignupController());
            })),
        GetPage(
            name: '/verify-email',
            page: () => const VerifyEmailScreen(),
            binding: BindingsBuilder(() {
              Get.put(VerifyEmailController());
            })),
        GetPage(name: '/forgot-password', page: () => const ForgetPassword()),
        GetPage(name: '/reset-password', page: () => const ResetPassword()),
        // Games
        GetPage(name: '/memo-game', page: () => const MemoryGameHome()),
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
        // show all content
        GetPage(name: '/show-all-content', page: () => const ShowAllContent()),
      ];
}
