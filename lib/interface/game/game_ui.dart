import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textspeech/util/game%20property/game_option.dart';

class MemoryGameHome extends StatelessWidget {
  const MemoryGameHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 25.0),
            child: Text(
              'Memory\nGame',
              style:
                  GoogleFonts.oswald(fontWeight: FontWeight.w500, fontSize: 35),
            ).animate(delay: const Duration(milliseconds: 250)).slideX(
                begin: -2, end: 0, duration: const Duration(milliseconds: 500)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      'Tingkat Kesulitan',
                      style: GoogleFonts.playfairDisplay(
                          fontWeight: FontWeight.w500, fontSize: 22),
                    ),
                  ).animate(delay: const Duration(milliseconds: 250)).slideY(
                      begin: 20,
                      end: 0,
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.bounceInOut),
                  const GameOptions()
                      .animate(delay: const Duration(milliseconds: 500))
                      .slideY(
                          begin: 5,
                          end: 0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.bounceInOut),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
