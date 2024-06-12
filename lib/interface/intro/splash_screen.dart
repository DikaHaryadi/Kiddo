import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:textspeech/util/etc/app_colors.dart';
import 'package:textspeech/util/etc/responsive.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
        body: isMobile(context)
            ? Stack(
                children: [
                  PageView(
                    controller: controller.pageController,
                    onPageChanged: controller.updatePageIndicator,
                    children: [
                      OnBoardingPage(
                        image: 'assets/animations/animation1.json',
                        title: 'Welcome to the World of Knowledge!'.tr,
                        titleTextStyle:
                            Theme.of(context).textTheme.headlineMedium,
                        subtitle:
                            'KiddieLearn Embark on a learning adventure with us. Discover a world of interesting and exciting knowledge!'
                                .tr,
                        bodyTextStyle: Theme.of(context).textTheme.bodyMedium,
                      ),
                      OnBoardingPage(
                          image: 'assets/animations/animation2.json',
                          title: 'Explore your potential with us!'.tr,
                          titleTextStyle:
                              Theme.of(context).textTheme.headlineMedium,
                          subtitle:
                              "At KiddieLearn, we believe that every child has tremendous potential. Let's explore interesting topics, and develop your creativity and skills!"
                                  .tr,
                          bodyTextStyle:
                              Theme.of(context).textTheme.bodyMedium),
                      OnBoardingPage(
                          image: 'assets/animations/animation3.json',
                          title: 'Learning is Fun with KiddieLearn!'.tr,
                          titleTextStyle:
                              Theme.of(context).textTheme.headlineMedium,
                          subtitle:
                              "With KiddieLearn, learning has never been so much fun! Discover learning resources that are interactive, challenging, and tailored to your needs. Let's get started!"
                                  .tr,
                          bodyTextStyle: Theme.of(context).textTheme.bodyMedium)
                    ],
                  ),
                  Positioned(
                      top: kToolbarHeight,
                      right: 24.0,
                      child: TextButton(
                        onPressed: () => controller.skipPage(),
                        child: AutoSizeText('Skip'.tr),
                      )),
                  Positioned(
                      bottom: kBottomNavigationBarHeight - 20,
                      left: 24.0,
                      child: SmoothPageIndicator(
                          controller: controller.pageController,
                          onDotClicked: controller.dotNavigationClick,
                          effect: const ExpandingDotsEffect(
                              activeDotColor: kDark, dotHeight: 6),
                          count: 3)),
                  Positioned(
                      right: 24.0,
                      bottom: kBottomNavigationBarHeight - 40,
                      child: ElevatedButton(
                          onPressed: controller.nextPage,
                          style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              backgroundColor: kDark),
                          child: const Icon(
                            Iconsax.next,
                            color: Colors.white,
                          )))
                ],
              )
            : Stack(
                children: [
                  PageView(
                    controller: controller.pageController,
                    onPageChanged: controller.updatePageIndicator,
                    children: [
                      OnBoardingPage(
                        image: 'assets/animations/animation1.json',
                        title: 'Welcome to the World of Knowledge!'.tr,
                        titleTextStyle:
                            Theme.of(context).textTheme.headlineLarge,
                        subtitle:
                            'KiddieLearn Embark on a learning adventure with us. Discover a world of interesting and exciting knowledge!'
                                .tr,
                        bodyTextStyle: Theme.of(context).textTheme.titleLarge,
                      ),
                      OnBoardingPage(
                        image: 'assets/animations/animation2.json',
                        title: 'Explore your potential with us!'.tr,
                        titleTextStyle:
                            Theme.of(context).textTheme.headlineLarge,
                        subtitle:
                            "At KiddieLearn, we believe that every child has tremendous potential. Let's explore interesting topics, and develop your creativity and skills!"
                                .tr,
                        bodyTextStyle: Theme.of(context).textTheme.titleLarge,
                      ),
                      OnBoardingPage(
                        image: 'assets/animations/animation3.json',
                        title: 'Learning is Fun with KiddieLearn!'.tr,
                        titleTextStyle:
                            Theme.of(context).textTheme.headlineLarge,
                        subtitle:
                            "With KiddieLearn, learning has never been so much fun! Discover learning resources that are interactive, challenging, and tailored to your needs. Let's get started!"
                                .tr,
                        bodyTextStyle: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                  Positioned(
                      top: kToolbarHeight,
                      right: 24.0,
                      child: TextButton(
                        onPressed: () => controller.skipPage(),
                        child: AutoSizeText(
                          'Skip'.tr,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      )),
                  Positioned(
                      bottom: kBottomNavigationBarHeight - 20,
                      left: 24.0,
                      child: SmoothPageIndicator(
                          controller: controller.pageController,
                          onDotClicked: controller.dotNavigationClick,
                          effect: const ExpandingDotsEffect(
                              activeDotColor: kDark,
                              dotHeight: 10.0,
                              dotWidth: 22.0),
                          count: 3)),
                  Positioned(
                      right: 24.0,
                      bottom: kBottomNavigationBarHeight - 40,
                      child: ElevatedButton(
                          onPressed: controller.nextPage,
                          style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              backgroundColor: kDark),
                          child: const Icon(
                            Iconsax.next,
                            color: Colors.white,
                          )))
                ],
              ));
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle,
      this.titleTextStyle,
      this.bodyTextStyle,
      this.language});

  final String image, title, subtitle;
  final TextStyle? titleTextStyle;
  final TextStyle? bodyTextStyle;
  final Widget? language;

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
            style: titleTextStyle,
          ),
          const SizedBox(height: 16.0),
          AutoSizeText(
            subtitle,
            textAlign: TextAlign.center,
            style: bodyTextStyle,
          ),
          language ?? const SizedBox.shrink()
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
    pageController.jumpToPage(2);
  }
}
