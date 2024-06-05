import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:textspeech/controllers/dino_controller.dart';
import 'package:textspeech/util/shimmer/card_swiper_shimmer.dart';
import 'package:textspeech/util/widgets/card_dino.dart';
import '../../util/etc/responsive.dart';
import '../homepage.dart';

class DinoSaurusScreens extends StatelessWidget {
  const DinoSaurusScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DinoController());
    return Scaffold(
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
                title: Text(
                  'Dinosaurus',
                  style: Theme.of(context).textTheme.headlineMedium,
                )
                    .animate(delay: const Duration(milliseconds: 250))
                    .fadeIn(duration: const Duration(milliseconds: 800)),
                centerTitle: true,
              )
            : null,
        body: SafeArea(
          child: isMobile(context)
              ? Obx(() => controller.isLoadingDino.value
                  ? const CardSwiperShimmer()
                  : CardDinoContent(controller: controller))
              : Center(
                  child: Text('Ini Dinosaurus Tablet'),
                ),
        ));
  }
}
