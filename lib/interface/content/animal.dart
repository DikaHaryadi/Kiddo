import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:textspeech/controllers/animal_controller.dart';
import 'package:textspeech/interface/homepage.dart';
import 'package:textspeech/interface/mobile/animal_mobile_screen.dart';
import 'package:textspeech/interface/tablet/animal_tablet_screen.dart';
import 'package:textspeech/util/etc/responsive.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../util/etc/app_colors.dart';

class AnimalContent extends StatefulWidget {
  const AnimalContent({
    super.key,
  });

  @override
  State<AnimalContent> createState() => _AnimalContentState();
}

class _AnimalContentState extends State<AnimalContent> {
  final controller = Get.put(AnimalController());
  int selectedIndex = 0;

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
          if (isMobile(context)) AnimalMobileScreen(controller: controller),
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
                            child: Scrollbar(
                              scrollbarOrientation: ScrollbarOrientation.left,
                              thickness: 5,
                              child: Container(
                                color: Colors.red,
                                child: AnimationLimiter(
                                    child: Obx(
                                  () => ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemCount: controller.animalModels.length,
                                    itemBuilder: (context, index) {
                                      final animal =
                                          controller.animalModels[index];
                                      return AnimationConfiguration
                                          .staggeredList(
                                        position: index,
                                        delay:
                                            const Duration(milliseconds: 250),
                                        duration:
                                            const Duration(milliseconds: 1000),
                                        child: SlideAnimation(
                                          verticalOffset: 44.0,
                                          child: FadeInAnimation(
                                            child: GestureDetector(
                                              onTap: () {
                                                if (index != selectedIndex) {
                                                  setState(() {
                                                    selectedIndex = index;
                                                  });
                                                }
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 15.0,
                                                  horizontal: 15.0,
                                                ),
                                                child: Row(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(10.0),
                                                      ),
                                                      child: Image.network(
                                                        animal.imageContent,
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
                                                          AutoSizeText(
                                                            animal.titleAnimal,
                                                            maxFontSize: 25,
                                                            minFontSize: 22,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          AutoSizeText(
                                                            '${animal.kategori}  |  ${animal.jenisMakanan}',
                                                            minFontSize: 16,
                                                            maxFontSize: 20,
                                                            style: GoogleFonts
                                                                .robotoSlab(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )),
                              ),
                            ),
                          ),
                          Container(
                            height: 300,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 15.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          ),
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            Get.offNamed('/home');
                                          },
                                          icon: const Icon(
                                            Icons.arrow_back_ios_new,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 35.0),
                                        child: AutoSizeText(
                                          'Today',
                                          minFontSize: 22,
                                          maxFontSize: 25,
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                AutoSizeText(
                                  DateFormat('EEEE, MMM d')
                                      .format(DateTime.now()),
                                  maxFontSize: 30,
                                  minFontSize: 25,
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold,
                                    color: kDark,
                                  ),
                                ),
                                Expanded(
                                  child: Image.asset(
                                    'assets/images/Logo_color1.png',
                                    width: 210,
                                  ),
                                ),
                              ],
                            ),
                          )
                              .animate(delay: const Duration(milliseconds: 250))
                              .slideY(
                                begin: 2.5,
                                end: 0,
                                duration: const Duration(milliseconds: 700),
                              ),
                        ],
                      )),
                  // Conditional rendering of AnimalTabletScreen

                  Obx(() => controller.animalModels.isNotEmpty
                      ? AnimalTabletScreen(
                          model: controller.animalModels[selectedIndex],
                        )
                      : const SizedBox.shrink())
                ],
              ),
            )
        ],
      ),
    );
  }
}
