import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:textspeech/controllers/family_controller.dart';
import 'package:textspeech/interface/homepage.dart';
import 'package:textspeech/interface/tablet/family_tablet_screen.dart';
import 'package:textspeech/util/etc/responsive.dart';
import 'package:textspeech/util/widgets/family_card.dart';

import '../../util/shimmer/content_shimmer.dart';

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
          if (isMobile(context))
            Column(
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
                    begin: -2.5,
                    end: 0,
                    duration: const Duration(milliseconds: 550)),
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
                                          model:
                                              controller.familyModel[index])),
                                ),
                              );
                            },
                          ),
                        ),
                )
              ],
            ),
          if (isDesktop(context))
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.blue,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.red,
                            child: AnimationLimiter(child: Obx(() {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.familyModel.length,
                                itemBuilder: (context, index) {
                                  final family = controller.familyModel[index];
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    delay: const Duration(milliseconds: 250),
                                    duration: const Duration(milliseconds: 500),
                                    child: SlideAnimation(
                                      verticalOffset: 44.0,
                                      child: FadeInAnimation(
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.selectedFamily.value =
                                                family;
                                          },
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15.0,
                                                      horizontal: 15.0),
                                              child: Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10.0)),
                                                    child: Image.network(
                                                      family.imageContent,
                                                      width: 60,
                                                      height: 60,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 15.0),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          family.subjectFamily,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          family.subtitle,
                                                          style: GoogleFonts
                                                              .robotoSlab(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            })),
                          ),
                        ),
                        Container(
                          height: 300,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 15.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      child: IconButton(
                                          onPressed: () {
                                            Get.offNamed('/home');
                                          },
                                          icon: const Icon(
                                            Icons.arrow_back_ios_new,
                                            color: Colors.black,
                                          )),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 35.0),
                                      child: Text(
                                        'Today',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                DateFormat('EEEE, MMM d')
                                    .format(DateTime.now()),
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              Expanded(
                                child: Image.asset(
                                  'assets/images/Logo_color1.png',
                                  width: 210,
                                ),
                              )
                            ],
                          ),
                        )
                            .animate(delay: const Duration(milliseconds: 250))
                            .slideY(
                                begin: 2.5,
                                end: 0,
                                duration: const Duration(milliseconds: 700)),
                      ],
                    ),
                  ),
                  Obx(() {
                    final selectedFamily = controller.selectedFamily.value;
                    if (selectedFamily != null) {
                      return FamilyTabletScreen(model: selectedFamily);
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
