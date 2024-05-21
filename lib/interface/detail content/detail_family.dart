import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/controllers/family_controller.dart';
import 'package:textspeech/models/family_model.dart';
import 'package:textspeech/util/etc/curved_edges.dart';
import 'package:textspeech/util/etc/family_info.dart';

import '../../controllers/tts_controller.dart';

class DetailFamily extends StatefulWidget {
  final FamilyModel model;
  const DetailFamily({
    super.key,
    required this.model,
  });

  @override
  State<DetailFamily> createState() => _DetailFamilyState();
}

class _DetailFamilyState extends State<DetailFamily> {
  late int currentIndex = -1;

  static Route<dynamic> _routeBuilder(
    BuildContext context,
    FamilyModel familyModel,
  ) {
    return MaterialPageRoute(
      builder: (_) {
        return DetailFamily(
          model: familyModel,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FamilyController());
    final ttsController = Get.put(TtsController());
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFfab800),
          leading: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      enableDrag: true,
                      useSafeArea: true,
                      clipBehavior: Clip.hardEdge,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return DraggableScrollableSheet(
                          expand: false,
                          initialChildSize: 0.5,
                          snap: true,
                          snapSizes: const [0.5, 1.0],
                          builder: (_, scrollController) {
                            return Obx(() => CustomScrollView(
                                  controller: scrollController,
                                  physics: const ClampingScrollPhysics(),
                                  slivers: [
                                    SliverPersistentHeader(
                                      delegate: FamilyInfoAppBar(
                                          controller.familyModel.length),
                                      pinned: true,
                                    ),
                                    AnimationLimiter(
                                      child: SliverList(
                                          delegate: SliverChildBuilderDelegate(
                                              (_, index) =>
                                                  AnimationConfiguration
                                                      .staggeredList(
                                                    position: index,
                                                    duration: const Duration(
                                                        milliseconds: 800),
                                                    child: SlideAnimation(
                                                      verticalOffset: 100.0,
                                                      child: FadeInAnimation(
                                                        child: ListTile(
                                                          onTap: () {
                                                            if (index !=
                                                                currentIndex) {
                                                              setState(() {
                                                                currentIndex =
                                                                    index;
                                                              });
                                                              Navigator
                                                                  .pushReplacement(
                                                                context,
                                                                _routeBuilder(
                                                                    context,
                                                                    controller
                                                                            .familyModel[
                                                                        index]),
                                                              );
                                                            }
                                                          },
                                                          leading: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                            child:
                                                                Image.network(
                                                              controller
                                                                  .familyModel[
                                                                      index]
                                                                  .imageContent,
                                                              width: 50,
                                                              height: 50,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          title: AutoSizeText(
                                                              controller
                                                                  .familyModel[
                                                                      index]
                                                                  .subjectFamily,
                                                              maxFontSize: 16,
                                                              minFontSize: 14,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: GoogleFonts.aBeeZee(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .black)),
                                                          subtitle: AutoSizeText(
                                                              controller
                                                                  .familyModel[
                                                                      index]
                                                                  .subtitle,
                                                              maxFontSize: 16,
                                                              minFontSize: 14,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: GoogleFonts.aBeeZee(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .black)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              childCount: controller
                                                  .familyModel.length)),
                                    )
                                  ],
                                ));
                          },
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Iconsax.firstline,
                    color: Colors.white,
                    size: 30,
                  ))
              .animate(delay: const Duration(milliseconds: 250))
              .fadeIn(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubic),
        ),
        body: Stack(
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
              top: height * 0.35,
              left: 30,
              child: Text(
                widget.model.subtitle,
                style: GoogleFonts.montserrat(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFa35e3e)),
              ).animate(delay: const Duration(milliseconds: 250)).slideX(
                  begin: -2,
                  end: 0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOutBack,
                  delay: const Duration(milliseconds: 100)),
            ),
            Positioned(
              right: 40,
              top: 180,
              bottom: 150,
              child: GestureDetector(
                onTap: () {
                  ttsController.textToSpeech(widget.model.subtitle);
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFa35e3e),
                  ),
                  child: const Icon(
                    Iconsax.play_circle,
                    color: Colors.white,
                    size: 40,
                  ),
                ).animate(delay: const Duration(milliseconds: 250)).slideX(
                    begin: 2,
                    end: 0,
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.fastEaseInToSlowEaseOut,
                    delay: const Duration(milliseconds: 100)),
              ),
            ),
            Positioned(
              top: height * 0.3,
              bottom: 10,
              left: 30,
              child: AutoSizeText(widget.model.subjectFamily,
                      maxFontSize: 26,
                      minFontSize: 22,
                      style: GoogleFonts.aBeeZee(
                          fontWeight: FontWeight.bold, color: Colors.white))
                  .animate(delay: const Duration(milliseconds: 250))
                  .slideX(
                      begin: -2,
                      end: 0,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeInOutBack,
                      delay: const Duration(milliseconds: 100)),
            ),
            Positioned(
              top: height * 0.55,
              bottom: 10,
              right: 20,
              left: 20,
              child: InkWell(
                onTap: () {
                  ttsController.textToSpeech(widget.model.deskripsiFamily);
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: AutoSizeText(
                    widget.model.deskripsiFamily,
                    maxFontSize: 18,
                    minFontSize: 16,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.aBeeZee(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ).animate(delay: const Duration(milliseconds: 250)).slideY(
                  begin: 3,
                  end: 0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOutBack,
                  delay: const Duration(milliseconds: 100)),
            )
          ],
        ));
  }
}
