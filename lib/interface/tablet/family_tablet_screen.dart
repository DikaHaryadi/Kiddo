import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/controllers/tts_controller.dart';
import 'package:textspeech/models/family_model.dart';

import '../../util/etc/curved_edges.dart';

class FamilyTabletScreen extends StatelessWidget {
  final FamilyModel model;
  const FamilyTabletScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final ttsController = Get.put(TtsController());
    return Expanded(
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
                top: 400,
                left: 30,
                child: Text(model.subjectFamily,
                        style: GoogleFonts.aBeeZee(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))
                    .animate(delay: const Duration(milliseconds: 250))
                    .fadeIn(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeInOutBack,
                        delay: const Duration(milliseconds: 100)),
              ),
              Positioned(
                top: 460,
                left: 30,
                child: Text(
                  model.subtitle,
                  style: GoogleFonts.montserrat(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFa35e3e)),
                ).animate(delay: const Duration(milliseconds: 250)).fadeIn(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOutBack,
                    delay: const Duration(milliseconds: 100)),
              ),
              Positioned(
                right: 60,
                top: 200,
                bottom: 150,
                child: GestureDetector(
                  onTap: () {
                    TtsController.instance.textToSpeech(model.subtitle);
                  },
                  child: Container(
                    width: 85,
                    height: 85,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFa35e3e),
                    ),
                    child: const Center(
                      child: Icon(
                        Iconsax.play_circle,
                        color: Colors.white,
                        size: 25,
                      ),
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
                bottom: 100,
                right: 20,
                left: 20,
                child: InkWell(
                  onTap: () {
                    ttsController.textToSpeech(model.deskripsiFamily);
                  },
                  child: Text(
                    model.deskripsiFamily,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.aBeeZee(
                      height: 1.4,
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
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
              )
            ],
          )),
    );
  }
}
