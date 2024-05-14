import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textspeech/controllers/banner_ads_controller.dart';
import 'package:textspeech/controllers/number_controller.dart';
import 'package:textspeech/interface/homepage.dart';
import 'package:textspeech/util/card_number.dart';
import 'package:textspeech/util/constants.dart';
import 'package:textspeech/util/responsive.dart';

import '../../controllers/tts_controller.dart';
import '../../util/shimmer/card_swiper_shimmer.dart';

class NumberContent extends StatefulWidget {
  const NumberContent({
    super.key,
  });

  @override
  State<NumberContent> createState() => _NumberContentState();
}

class _NumberContentState extends State<NumberContent> {
  final CardSwiperController controller = CardSwiperController();
  final adsController = Get.put(BannerAdsController());

  int selectedIndex = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NumberController());
    String counterPath = numsList[selectedIndex]['counterPath']!;
    String name = numsList[selectedIndex]['name']!;
    String title = numsList[selectedIndex]['title']!;
    return Scaffold(
        appBar: isMobile(context)
            ? AppBar(
                leading: IconButton(
                  onPressed: () {
                    Future.delayed(const Duration(milliseconds: 250), () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ));
                    });
                  },
                  icon: const Icon(Icons.arrow_back_ios)
                      .animate(delay: const Duration(milliseconds: 250))
                      .slideX(
                          begin: 2,
                          end: 0,
                          duration: const Duration(milliseconds: 300)),
                ),
                title: AutoSizeText('Bilangan Angka',
                        style: Theme.of(context).textTheme.headlineMedium)
                    .animate(delay: const Duration(milliseconds: 250))
                    .slideX(
                        begin: 1,
                        end: 0,
                        duration: const Duration(milliseconds: 400)),
                centerTitle: true,
              )
            : null,
        body: SafeArea(
            child: isMobile(context)
                ? Column(
                    children: [
                      Flexible(
                        child: Obx(() => controller.isLoadingNumber.value
                            ? const CardSwiperShimmer()
                            : CardNumberContent(controller: controller)),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Container(
                            color: const Color(0xFFfcf4f1),
                            padding: const EdgeInsets.only(
                                top: 50.0, left: 35.0, right: 40.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                        onPressed: () => Get.offNamed('/home'),
                                        icon: const Icon(
                                          Icons.arrow_back_ios,
                                          size: 50,
                                        ))
                                    .animate()
                                    .slideX(
                                        begin: -2,
                                        end: 0,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeIn),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    'Numbers',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 50),
                                  ).animate().slideX(
                                      begin: -2,
                                      end: 0,
                                      duration:
                                          const Duration(milliseconds: 700),
                                      curve: Curves.easeIn),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    'Today, we will learn about numbers with great enthusiasm',
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey.shade400,
                                        fontSize: 40),
                                  ).animate().slideX(
                                      begin: -2,
                                      end: 0,
                                      duration:
                                          const Duration(milliseconds: 900),
                                      curve: Curves.easeIn),
                                ),
                                Center(
                                    child: Padding(
                                  padding: const EdgeInsets.only(top: 50.0),
                                  child: InkWell(
                                    onTap: () {
                                      TtsController.instance.textToSpeech(name);
                                    },
                                    child: Image.asset(counterPath)
                                        .animate()
                                        .fadeIn(
                                            duration: const Duration(
                                                milliseconds: 2000),
                                            curve: Curves.easeIn),
                                  ),
                                )),
                                Center(
                                    child: Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: Text(
                                    title,
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40),
                                  ).animate().fadeIn(
                                      duration:
                                          const Duration(milliseconds: 2000),
                                      curve: Curves.easeIn),
                                )),
                                adsController.getAdWidget(),
                                const Spacer(),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'click on the image to reveal the sound',
                                    style: GoogleFonts.roboto(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ).animate().slideY(
                                      begin: 1,
                                      end: 0,
                                      duration:
                                          const Duration(milliseconds: 1100),
                                      curve: Curves.bounceInOut),
                                )
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.only(
                                top: 50.0, left: 10.0, right: 10.0),
                            child: AnimationLimiter(
                              child: GridView.count(
                                crossAxisCount: 2,
                                mainAxisSpacing: 35,
                                childAspectRatio:
                                    MediaQuery.of(context).size.aspectRatio,
                                children:
                                    List.generate(numsList.length, (index) {
                                  return AnimationConfiguration.staggeredGrid(
                                    columnCount: 2,
                                    position: index,
                                    delay: const Duration(milliseconds: 250),
                                    duration: const Duration(milliseconds: 500),
                                    child: ScaleAnimation(
                                      scale: 0.5,
                                      child: FadeInAnimation(
                                        child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedIndex = index;
                                              });
                                            },
                                            child: Image.asset(
                                              numsList[index]['imagePath']!,
                                            )),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          )),
                    ],
                  )));
  }
}
