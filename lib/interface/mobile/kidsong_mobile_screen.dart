import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:textspeech/controllers/kidsong_controller.dart';
import 'package:textspeech/util/shimmer/content_shimmer.dart';
import 'package:textspeech/util/widgets/kid_song_card.dart';

class KidSongMobileScreen extends StatelessWidget {
  final KidSongController controller;
  const KidSongMobileScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 18 / 9,
          child: AnimationConfiguration.staggeredGrid(
            position: 0,
            duration: const Duration(milliseconds: 900),
            columnCount: 1,
            child: FadeInAnimation(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  'assets/banner_musik.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 25.0),
        AutoSizeText('PlayList',
                style: Theme.of(context).textTheme.headlineMedium)
            .animate(delay: const Duration(milliseconds: 250))
            .slideX(
                begin: -2.5,
                end: 0,
                duration: const Duration(milliseconds: 550)),
        const SizedBox(height: 20.0),
        Obx(
          () => controller.isLoadingAnimal.value
              ? const ContentShimmer()
              : AnimationLimiter(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.kidSongModel.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        delay: const Duration(milliseconds: 250),
                        duration: const Duration(milliseconds: 800),
                        child: SlideAnimation(
                          verticalOffset: 100.0,
                          child: FadeInAnimation(
                              child: KidSongCardScreen(
                                  model: controller.kidSongModel[index])),
                        ),
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }
}
