import 'package:get/get.dart';
import 'package:textspeech/auth/controller/sign_up_controller.dart';
import 'package:textspeech/auth/controller/verify_email_controller.dart';
import 'package:textspeech/controllers/lagu_nasional.dart';
import 'package:textspeech/controllers/question_controller.dart';
import 'package:textspeech/interface/content/dino.dart';
import 'package:textspeech/interface/content/info_app.dart';
import 'package:textspeech/interface/content/kid_song.dart';
import 'package:textspeech/interface/content/lagu_nasional.dart';
import 'package:textspeech/quiz/answer_check_screen.dart';
import 'package:textspeech/quiz/result_screen.dart';
import 'package:textspeech/interface/content/animal.dart';
import 'package:textspeech/interface/content/family.dart';
import 'package:textspeech/interface/content/numbers.dart';
import 'package:textspeech/interface/detail%20content/showall_content.dart';
import 'package:textspeech/interface/user/edit_profile.dart';
import 'package:textspeech/interface/game/game_ui.dart';
import 'package:textspeech/interface/homepage.dart';
import 'package:textspeech/interface/intro/introduction_screen.dart';
import 'package:textspeech/auth/sign_up.dart';
import 'package:textspeech/interface/user/profile.dart';
import 'package:textspeech/interface/intro/splash_screen.dart';
import 'package:textspeech/auth/verify_email.dart';
import 'package:textspeech/quiz/question_paper_controller.dart';
import 'package:textspeech/interface/game/quiz_screen.dart';
import 'package:textspeech/quiz/question_screen.dart';
import 'package:textspeech/services/message.dart';
import 'package:textspeech/util/widgets/change_name.dart';
import 'package:textspeech/util/widgets/change_username.dart';

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
        // Games
        GetPage(name: '/memo-game', page: () => const MemoryGameHome()),
        GetPage(
            name: '/main-menu-quiz',
            page: () => const QuizScreen(),
            binding: BindingsBuilder(() {
              Get.put(QuestionPaperController());
            })),
        GetPage(
            name: QuestionScreen.routeName,
            page: () => const QuestionScreen(),
            binding: BindingsBuilder(() {
              Get.put<QuestionController>(QuestionController());
            })),

        GetPage(
            name: ResultQuizScreen.routeName,
            page: () => const ResultQuizScreen(),
            binding: BindingsBuilder(() {
              Get.put<QuestionController>(QuestionController());
            })),
        GetPage(
          name: AnswereCheckScreen.routeName,
          page: () => const AnswereCheckScreen(),
        ),

        // Content
        GetPage(name: '/number-content', page: () => const NumberContent()),
        GetPage(name: '/animals-content', page: () => const AnimalContent()),
        GetPage(name: '/kid-song', page: () => const KidSong()),
        GetPage(name: '/family-content', page: () => const FamilyContent()),
        GetPage(name: '/dino', page: () => const DinoSaurusScreens()),

        GetPage(
            name: '/lagu-nasional',
            page: () => const LaguNasionalContent(),
            binding: BindingsBuilder(() {
              Get.put(LaguNasionalController());
            })),

        // show all content
        GetPage(name: '/show-all-content', page: () => const ShowAllContent()),
        // profile
        GetPage(name: '/profile', page: () => const ProfileScreen()),
        // edit profile
        GetPage(name: '/edit-profile', page: () => const EditProfileScreen()),
        GetPage(name: '/edit-name', page: () => const ChangeName()),
        GetPage(name: '/edit-username', page: () => const ChangeUserName()),

        // notif
        GetPage(name: '/message', page: () => const MessageScreen()),

        // info app
        GetPage(
          name: '/info-app',
          page: () => const InfoAppScreen(),
        )
      ];
}
