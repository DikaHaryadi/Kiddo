import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textspeech/controllers/family_controller.dart';

import '../../util/shimmer/content_shimmer.dart';
import '../../util/widgets/family_card.dart';

class FamilyMobileScreen extends StatelessWidget {
  final FamilyController controller;
  const FamilyMobileScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 18 / 9,
          child: AnimationConfiguration.staggeredGrid(
            position: 0,
            delay: const Duration(milliseconds: 250),
            duration: const Duration(milliseconds: 900),
            columnCount: 1,
            child: FadeInAnimation(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  'assets/banner_family.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 25.0),
        AutoSizeText(
          'Categories',
          maxFontSize: 20,
          minFontSize: 18,
          style: GoogleFonts.aBeeZee(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ).animate(delay: const Duration(milliseconds: 250)).slideX(
            begin: -2.5, end: 0, duration: const Duration(milliseconds: 550)),
        const SizedBox(height: 20.0),
        Obx(
          () => controller.isLoadingFamily.value
              ? const ContentShimmer()
              : AnimationLimiter(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.familyModel.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 800),
                        child: SlideAnimation(
                          verticalOffset: 100.0,
                          child: FadeInAnimation(
                              child: FamilyCardScreen(
                                  model: controller.familyModel[index])),
                        ),
                      );
                    },
                  ),
                ),
        )
      ],
    );
  }
}
