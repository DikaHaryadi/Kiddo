import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textspeech/controllers/dino_controller.dart';
import 'package:textspeech/interface/tablet/dino_tablet_screen.dart';
import 'package:textspeech/util/widgets/card_dino.dart';
import '../../util/etc/responsive.dart';

class DinoSaurusScreens extends StatelessWidget {
  const DinoSaurusScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DinoController());
    return Scaffold(
        body: SafeArea(
            child: isMobile(context)
                ? Obx(() {
                    final selectedDino = controller.selectedDino.value;
                    if (selectedDino != null) {
                      return CardDinoContent(
                          controller: controller, model: selectedDino);
                    } else {
                      return const SizedBox.shrink();
                    }
                  })
                : Obx(() {
                    final selectedDino = controller.selectedDino.value;
                    if (selectedDino != null) {
                      return DinoTabletScreen(
                          controller: controller, model: selectedDino);
                    } else {
                      return const SizedBox.shrink();
                    }
                  })));
  }
}
