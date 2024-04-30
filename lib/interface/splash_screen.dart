import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:textspeech/util/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: controller.pageController,
          onPageChanged: controller.updatePageIndicator,
          children: const [
            OnBoardingPage(
              image: 'assets/animations/animation1.json',
              title: 'Welcome to the World of Knowledge!',
              subtitle:
                  'KiddieLearn Embark on a learning adventure with us. Discover a world of interesting and exciting knowledge!',
            ),
            OnBoardingPage(
              image: 'assets/animations/animation2.json',
              title: 'Explore your potential with us!',
              subtitle:
                  "At KiddieLearn, we believe that every child has tremendous potential. Let's explore interesting topics, and develop your creativity and skills!",
            ),
            OnBoardingPage(
              image: 'assets/animations/animation3.json',
              title: 'Learning is Fun with KiddieLearn!',
              subtitle:
                  "With KiddieLearn, learning has never been so much fun! Discover learning resources that are interactive, challenging, and tailored to your needs. Let's get started!",
            )
          ],
        ),
        Positioned(
            top: kToolbarHeight,
            right: 24.0,
            child: TextButton(
              onPressed: () => controller.skipPage(),
              child: const AutoSizeText('Skip'),
            )),
        Positioned(
            bottom: kBottomNavigationBarHeight + 25,
            left: 24.0,
            child: SmoothPageIndicator(
                controller: controller.pageController,
                onDotClicked: controller.dotNavigationClick,
                effect: const ExpandingDotsEffect(
                    activeDotColor: kDark, dotHeight: 6),
                count: 3)),
        Positioned(
            right: 24.0,
            bottom: kBottomNavigationBarHeight,
            child: ElevatedButton(
                onPressed: controller.nextPage,
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(), backgroundColor: kDark),
                child: const Icon(
                  Iconsax.arrow_right3,
                  color: Colors.white,
                )))
      ],
    ));
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Lottie.asset(
            image,
            width: MediaQuery.of(Get.context!).size.width * .8,
            height: MediaQuery.of(Get.context!).size.height * .6,
          ),
          AutoSizeText(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16.0),
          AutoSizeText(
            subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

// onboarding controllernya disini
class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  void updatePageIndicator(index) {
    currentPageIndex.value = index;
  }

  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  void nextPage() {
    if (currentPageIndex.value == 2) {
      final storage = GetStorage();
      storage.write('IsFirstTime', false);
      Get.offAllNamed('/introduction');
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpTo(2);
  }
}
