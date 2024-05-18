import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/models/animal_model.dart';

import '../../util/etc/curved_edges.dart';

class AnimalTabletScreen extends StatefulWidget {
  final AnimalModel model;
  const AnimalTabletScreen({super.key, required this.model});

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
    );
  }
}
