import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:textspeech/controllers/animal_controller.dart';
import 'package:textspeech/interface/homepage.dart';
import 'package:textspeech/interface/mobile/animal_mobile_screen.dart';
import 'package:textspeech/interface/tablet/animal_tablet_screen.dart';
import 'package:textspeech/util/etc/responsive.dart';

class AnimalContent extends StatelessWidget {
  const AnimalContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AnimalController());

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
                'Animals',
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
          if (isMobile(context)) AnimalMobileScreen(controller: controller),
          if (isDesktop(context))
            // Conditional rendering of AnimalTabletScreen
            Obx(() {
              final selectedAnimals = controller.selectedAnimal.value;
              if (selectedAnimals != null) {
                return AnimalTabletScreen(
                    controller: controller, model: selectedAnimals);
              } else {
                return const SizedBox.shrink();
              }
            }),
        ],
      ),
    );
  }
}
