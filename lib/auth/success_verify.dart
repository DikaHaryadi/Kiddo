import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:textspeech/util/etc/app_colors.dart';

class SuccessVerify extends StatelessWidget {
  const SuccessVerify(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.onPressed});

  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 54),
            child: Column(
              children: [
                Lottie.asset(
                  image,
                  width: MediaQuery.of(context).size.width * 0.6,
                ),
                const SizedBox(height: 16.0),
                AutoSizeText(
                  title,
                  textAlign: TextAlign.center,
                  minFontSize: 20,
                  maxFontSize: 22,
                  style: GoogleFonts.archivoBlack(),
                ),
                const SizedBox(height: 16.0),
                AutoSizeText(
                  subTitle,
                  textAlign: TextAlign.center,
                  minFontSize: 14,
                  maxFontSize: 16,
                  style: GoogleFonts.aBeeZee(color: kGrey),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.blueAccent)),
                    onPressed: onPressed,
                    child: AutoSizeText(
                      'Selanjutnya'.tr,
                      style: GoogleFonts.archivoBlack(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
