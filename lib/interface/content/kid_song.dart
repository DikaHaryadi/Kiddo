import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:textspeech/controllers/kidsong_controller.dart';
import 'package:textspeech/interface/homepage.dart';
import 'package:textspeech/interface/mobile/kidsong_mobile_screen.dart';
import 'package:textspeech/util/etc/responsive.dart';

class KidSong extends StatefulWidget {
  const KidSong({
    super.key,
  });

  @override
  State<KidSong> createState() => _KidSongState();
}

class _KidSongState extends State<KidSong> {
  final controller = Get.put(KidSongController());

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
          if (isMobile(context)) KidSongMobileScreen(controller: controller),
          if (isDesktop(context))
            // Conditional rendering of AnimalTabletScreen
            Obx(() {
              final selectedAnimals = controller.selectedAnimal.value;
              if (selectedAnimals != null) {
                return Text('Nanti disini buat tablet');
              } else {
                return const SizedBox.shrink();
              }
            }),
        ],
      ),
    );
  }
}
