import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textspeech/controllers/letter_controller.dart';

import '../../controllers/tts_controller.dart';
import '../../util/shimmer/tablet_shimmer.dart';

class LetterTabletScreen extends StatelessWidget {
  final LetterController letterController;
  const LetterTabletScreen({super.key, required this.letterController});

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
                    child: AutoSizeText(
                      'Hijaiyah',
                      maxFontSize: 50,
                      minFontSize: 45,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                      ),
                    ).animate().slideX(
                        begin: -2,
                        end: 0,
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeIn),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: AutoSizeText(
                      'Today, we will learn about the hijaiyah letters.',
                      maxFontSize: 40,
                      minFontSize: 35,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade400,
                      ),
                    ).animate().slideX(
                        begin: -2,
                        end: 0,
                        duration: const Duration(milliseconds: 900),
                        curve: Curves.easeIn),
                  ),
                  Obx(() {
                    final letter = letterController.selectedLetter.value;
                    if (letter == null) {
                      return const SizedBox.shrink();
                    }
                    return Column(
                      children: [
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: InkWell(
                            onTap: () {
                              ttsController.textToSpeech(letter.name);
                            },
                            child: Image.network(
                              letter.subImage,
                              width: double.infinity,
                              height: 400,
                            ).animate().fadeIn(
                                duration: const Duration(milliseconds: 2000),
                                curve: Curves.easeIn),
                          ),
                        )),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: AutoSizeText(
                            letter.name,
                            maxFontSize: 40,
                            minFontSize: 35,
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                            ),
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
                    child: AutoSizeText(
                      'click on the image to reveal the sound',
                      maxFontSize: 25,
                      minFontSize: 22,
                      style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                    ).animate().slideY(
                        begin: 1,
                        end: 0,
                        duration: const Duration(milliseconds: 1100),
                        curve: Curves.bounceInOut),
                  )
                ],
              ),
            )),
        Obx(
          () {
            if (letterController.isLoadingLetter.value) {
              return const TabletShimmer();
            } else {
              return AnimationLimiter(
                child: Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(top: 20.0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 35,
                      childAspectRatio: MediaQuery.of(context).size.aspectRatio,
                      children: List.generate(
                        letterController.letterModel.length,
                        (index) {
                          final letter = letterController.letterModel[index];
                          return AnimationConfiguration.staggeredGrid(
                            columnCount: 2,
                            position: index,
                            delay: const Duration(milliseconds: 200),
                            duration: const Duration(milliseconds: 800),
                            child: ScaleAnimation(
                              scale: 0.5,
                              child: FadeInAnimation(
                                child: GestureDetector(
                                  onTap: () {
                                    letterController.selectedLetter.value =
                                        letter;
                                  },
                                  child: Image.network(
                                    letter.imagePath,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
