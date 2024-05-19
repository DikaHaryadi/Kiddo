import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:textspeech/controllers/family_controller.dart';
import 'package:textspeech/interface/homepage.dart';
import 'package:textspeech/interface/mobile/family_mobile_screen.dart';
import 'package:textspeech/interface/tablet/family_tablet_screen.dart';
import 'package:textspeech/util/etc/responsive.dart';

class FamilyContent extends StatelessWidget {
  const FamilyContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FamilyController());

    return Scaffold(
      backgroundColor: const Color(0xFFfcf4f1),
      appBar: isMobile(context)
          ? AppBar(
              backgroundColor: const Color(0xFFfcf4f1),
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
                        begin: -2,
                        end: 0,
                        duration: const Duration(milliseconds: 300)),
              ),
              title: AutoSizeText('Family',
                      style: Theme.of(context).textTheme.headlineMedium)
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
          if (isMobile(context)) FamilyMobileScreen(controller: controller),
          if (isDesktop(context))
            Obx(() {
              final selectedFamily = controller.selectedFamily.value;
              if (selectedFamily != null) {
                return FamilyTabletScreen(
                    controller: controller, model: selectedFamily);
              } else {
                return const SizedBox.shrink();
              }
            }),
        ],
      ),
    );
  }
}
