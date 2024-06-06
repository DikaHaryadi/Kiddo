import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:textspeech/controllers/letter_controller.dart';
import 'package:textspeech/interface/homepage.dart';
import 'package:textspeech/interface/tablet/letter_tablet_screen.dart';
import 'package:textspeech/util/widgets/card_letter.dart';
import 'package:textspeech/util/etc/responsive.dart';

import '../../util/shimmer/card_swiper_shimmer.dart';

class LettersContent extends StatelessWidget {
  const LettersContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final letterController = Get.put(LetterController());

    return Scaffold(
        appBar: isMobile(context)
            ? AppBar(
                elevation: 0,
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
                title: Text('Huruf Hijaiyah',
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
                ? Obx(() {
                    final selectedLetter =
                        letterController.selectedLetter.value;
                    if (letterController.isLoadingLetter.value) {
                      return const CardSwiperShimmer();
                    } else {
                      return CardLetterContent(
                        controller: letterController,
                        model: selectedLetter!,
                      );
                    }
                  })
                : LetterTabletScreen(letterController: letterController)));
  }
}
