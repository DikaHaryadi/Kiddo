import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textspeech/controllers/number_controller.dart';
import 'package:textspeech/controllers/tts_controller.dart';

import '../../util/shimmer/tablet_shimmer.dart';

class NumberTabletScreen extends StatelessWidget {
  final NumberController controller;
  const NumberTabletScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final ttsController = Get.put(TtsController());
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Container(
              color: const Color(0xFFfcf4f1),
              padding:
                  const EdgeInsets.only(top: 50.0, left: 35.0, right: 40.0),
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
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text('Numbers',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(fontSize: 50))
                        .animate()
                        .slideX(
                            begin: -2,
                            end: 0,
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.easeIn),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Today, we will learn about numbers with great enthusiasm',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(
                              fontWeight: FontWeight.normal,
                              fontSize: 35,
                              color: Colors.grey.shade400),
                    ).animate().slideX(
                        begin: -2,
                        end: 0,
                        duration: const Duration(milliseconds: 900),
                        curve: Curves.easeIn),
                  ),
                  Obx(() {
                    final numbers = controller.selectedNumber.value;
                    if (numbers == null) {
                      return const SizedBox.shrink();
                    }
                    return Column(
                      children: [
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: InkWell(
                            onTap: () {
                              ttsController.textToSpeech(numbers.speech);
                            },
                            child: Image.network(numbers.subImage)
                                .animate()
                                .fadeIn(
                                    duration:
                                        const Duration(milliseconds: 2000),
                                    curve: Curves.easeIn),
                          ),
                        )),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Text(
                            numbers.name,
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold, fontSize: 40),
                          ).animate().fadeIn(
                              duration: const Duration(milliseconds: 2000),
                              curve: Curves.easeIn),
                        )),
                      ],
                    );
                  }),
                  const Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Text('click on the image to reveal the sound',
                            style: Theme.of(context).textTheme.headlineSmall)
                        .animate()
                        .slideY(
                            begin: 1,
                            end: 0,
                            duration: const Duration(milliseconds: 1100),
                            curve: Curves.bounceInOut),
                  )
                ],
              ),
            )),
        Obx(() {
          if (controller.isLoadingNumber.value) {
            return const TabletShimmer();
          } else {
            return Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: AnimationLimiter(
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 35,
                      childAspectRatio: MediaQuery.of(context).size.aspectRatio,
                      children: List.generate(controller.numberModels.length,
                          (index) {
                        final numbers = controller.numberModels[index];
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
                                    controller.selectedNumber.value = numbers;
                                  },
                                  child: Image.network(
                                    numbers.imagePath,
                                  )),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ));
          }
        })
      ],
    );
  }
}
