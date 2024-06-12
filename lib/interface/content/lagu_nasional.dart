import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:textspeech/controllers/lagu_nasional.dart';
import 'package:textspeech/interface/mobile/lagu_nasional_mobile_screen.dart';
import 'package:textspeech/interface/tablet/lagu_nasional_screen.dart';

import '../../util/etc/responsive.dart';
import '../homepage.dart';

class LaguNasionalContent extends GetView<LaguNasionalController> {
  const LaguNasionalContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfcf4f1),
      appBar: isMobile(context)
          ? AppBar(
              elevation: 0,
              backgroundColor: const Color(0xFFfcf4f1),
              leading: IconButton(
                onPressed: () {
                  Future.delayed(const Duration(milliseconds: 250), () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  });
                },
                icon: const Icon(Icons.arrow_back_ios)
                    .animate(delay: const Duration(milliseconds: 250))
                    .slideX(
                      begin: -2,
                      end: 0,
                      duration: const Duration(milliseconds: 300),
                    ),
              ),
              title: AutoSizeText(
                'National Anthem',
                style: Theme.of(context).textTheme.headlineMedium,
              )
                  .animate(delay: const Duration(milliseconds: 250))
                  .fadeIn(duration: const Duration(milliseconds: 800)),
              centerTitle: true,
            )
          : null,
      body: ListView(
        padding: isMobile(context)
            ? const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0)
            : EdgeInsets.zero,
        children: [
          if (isMobile(context))
            LaguNasionalMobileScreen(controller: controller),
          if (isDesktop(context))
            Obx(() {
              final selectedLaguNasional = controller.selectedAnimal.value;
              if (selectedLaguNasional != null) {
                return LaguNasionalTabletScreen(
                  model: selectedLaguNasional,
                );
              } else {
                return const SizedBox.shrink();
              }
            })
        ],
      ),
    );
  }
}
