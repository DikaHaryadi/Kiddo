import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:textspeech/controllers/number_controller.dart';
import 'package:textspeech/interface/homepage.dart';
import 'package:textspeech/interface/tablet/number_tablet_screen.dart';
import 'package:textspeech/util/widgets/card_number.dart';
import 'package:textspeech/util/etc/responsive.dart';

import '../../util/shimmer/card_swiper_shimmer.dart';

class NumberContent extends StatelessWidget {
  const NumberContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NumberController());
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
                ? Obx(() => controller.isLoadingNumber.value
                    ? const CardSwiperShimmer()
                    : CardNumberContent(controller: controller))
                : NumberTabletScreen(controller: controller)));
  }
}
