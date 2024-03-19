import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class GameControlsBottomSheet extends StatelessWidget {
  final VoidCallback? startTime;
  final VoidCallback? resetGame;
  const GameControlsBottomSheet({super.key, this.startTime, this.resetGame});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * .45,
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
            border: const Border.fromBorderSide(BorderSide(color: Colors.red)),
            borderRadius: BorderRadius.circular(30.0)),
        // margin: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration(
                  border: const Border(
                    bottom: BorderSide(width: 2.0, color: Colors.orange),
                  ),
                  borderRadius: BorderRadius.circular(30.0)),
              child: Text(
                'Game Pause',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserratAlternates(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  shadows: [
                    const Shadow(
                      color: Colors.white,
                      blurRadius: 2,
                      offset: Offset(2, 1),
                    ),
                  ],
                ),
              ),
            ).animate().slideY(
                begin: 2,
                end: 0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.bounceInOut),
            const Spacer(),
            GestureDetector(
              onTap: () {
                startTime;
                Get.back(closeOverlays: false);
              },
              child: Container(
                width: double.infinity,
                height: 65,
                margin: const EdgeInsets.symmetric(horizontal: 50),
                decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(30.0)),
                child: Center(
                  child: Text(
                    'Continue',
                    style: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                ),
              ).animate(delay: const Duration(milliseconds: 500)).fadeIn(
                  curve: Curves.easeIn,
                  duration: const Duration(milliseconds: 500)),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                resetGame;
                Get.back(closeOverlays: true);
              },
              child: Container(
                      width: double.infinity,
                      height: 65,
                      margin: const EdgeInsets.symmetric(horizontal: 50),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Center(
                        child: Text(
                          'Restart',
                          style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                      ))
                  .animate(delay: const Duration(milliseconds: 500))
                  .fadeIn(
                      curve: Curves.easeIn,
                      duration: const Duration(milliseconds: 500)),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => Get.offAllNamed('/'),
              child: Container(
                width: double.infinity,
                height: 65,
                margin: const EdgeInsets.symmetric(horizontal: 50),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30.0)),
                child: Center(
                    child: Text(
                  'Main Menu',
                  style: GoogleFonts.aBeeZee(
                      fontWeight: FontWeight.w500, fontSize: 20),
                )),
              ).animate(delay: const Duration(milliseconds: 500)).fadeIn(
                  curve: Curves.easeIn,
                  duration: const Duration(milliseconds: 500)),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration(
                  border: const Border(
                    top: BorderSide(width: 2.0, color: Colors.orange),
                  ),
                  borderRadius: BorderRadius.circular(30.0)),
              child: Center(
                  child: Text(
                'Memory Game',
                style: GoogleFonts.montserratAlternates(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  shadows: [
                    const Shadow(
                      color: Colors.white,
                      blurRadius: 2,
                      offset: Offset(2, 1),
                    ),
                  ],
                ),
              )),
            ).animate().slideY(
                begin: -2,
                end: 0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.bounceInOut),
          ],
        ),
      ),
    );
  }
}
