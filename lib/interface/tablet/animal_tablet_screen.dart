import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:textspeech/controllers/animal_controller.dart';
import 'package:textspeech/models/animal_model.dart';

import '../../util/etc/app_colors.dart';
import '../../util/etc/curved_edges.dart';

class AnimalTabletScreen extends StatefulWidget {
  final AnimalModel model;
  final AnimalController controller;
  const AnimalTabletScreen(
      {super.key, required this.model, required this.controller});

  @override
  State<AnimalTabletScreen> createState() => _AnimalTabletScreenState();
}

class _AnimalTabletScreenState extends State<AnimalTabletScreen> {
  bool isPlaying = false;

  late final AudioPlayer player;
  late UrlSource path;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    path = UrlSource(widget.model.audio);
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void playPause() async {
    if (isPlaying) {
      player.pause();
      isPlaying = false;
    } else {
      player.play(path);
      isPlaying = true;
    }
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant AnimalTabletScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update path when widget.model changes
    if (widget.model != oldWidget.model) {
      path = UrlSource(widget.model.audio);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: widget.controller.animalModels.length,
                            itemBuilder: (context, index) {
                              final animal =
                                  widget.controller.animalModels[index];
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                delay: const Duration(milliseconds: 250),
                                duration: const Duration(milliseconds: 1000),
                                child: SlideAnimation(
                                  verticalOffset: 44.0,
                                  child: FadeInAnimation(
                                    child: GestureDetector(
                                      onTap: () {
                                        widget.controller.selectedAnimal.value =
                                            animal;
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 15.0,
                                          horizontal: 15.0,
                                        ),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
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
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  AutoSizeText(
                                                    animal.titleAnimal,
                                                    maxFontSize: 25,
                                                    minFontSize: 22,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  AutoSizeText(
                                                    '${animal.kategori}  |  ${animal.jenisMakanan}',
                                                    minFontSize: 16,
                                                    maxFontSize: 20,
                                                    style:
                                                        GoogleFonts.robotoSlab(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
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
                        ),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                padding: const EdgeInsets.only(left: 35.0),
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
                          DateFormat('EEEE, MMM d').format(DateTime.now()),
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
                  ).animate(delay: const Duration(milliseconds: 250)).slideY(
                        begin: 2.5,
                        end: 0,
                        duration: const Duration(milliseconds: 700),
                      ),
                ],
              )),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  ClipPath(
                    clipper: FamilyCurvedEdges(),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height,
                      color: const Color(0xFFfab800),
                    ),
                  ),
                  Positioned(
                    top: Get.height * 0.35,
                    left: 30,
                    child: Text(
                      widget.model.titleAnimal,
                      style: GoogleFonts.aBeeZee(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ).animate(delay: const Duration(milliseconds: 250)).fadeIn(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeInOutBack,
                          delay: const Duration(milliseconds: 100),
                        ),
                  ),
                  Positioned(
                    top: Get.height * 0.4,
                    left: 30.0,
                    child: Text(
                      '${widget.model.kategori} | ${widget.model.jenisMakanan}',
                      style: GoogleFonts.montserrat(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFa35e3e),
                      ),
                    ).animate(delay: const Duration(milliseconds: 250)).fadeIn(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeInOutBack,
                          delay: const Duration(milliseconds: 100),
                        ),
                  ),
                  Positioned(
                    right: 60,
                    top: 200,
                    bottom: 150,
                    child: GestureDetector(
                      onTap: playPause,
                      child: Container(
                        width: 85,
                        height: 85,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFa35e3e),
                        ),
                        child: Center(
                          child: Icon(
                            isPlaying ? Iconsax.pause : Iconsax.play_circle,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      )
                          .animate(delay: const Duration(milliseconds: 250))
                          .slideX(
                            begin: 2,
                            end: 0,
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.fastEaseInToSlowEaseOut,
                            delay: const Duration(milliseconds: 100),
                          ),
                    ),
                  ),
                  Positioned(
                    top: Get.height * 0.6,
                    bottom: 10,
                    right: 20,
                    left: 20,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: AutoSizeText(
                        widget.model.deskripsiAnimal,
                        maxFontSize: 25,
                        minFontSize: 22,
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.aBeeZee(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    )
                        .animate(
                          delay: const Duration(milliseconds: 250),
                        )
                        .slideY(
                          begin: 3,
                          end: 0,
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeInOutBack,
                          delay: const Duration(milliseconds: 100),
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
