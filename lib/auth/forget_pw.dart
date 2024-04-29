import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/util/app_colors.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: const EdgeInsets.only(left: 24),
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(bottom: 24, right: 24, left: 24, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              "Forget password",
              minFontSize: 22,
              maxFontSize: 24,
              style: GoogleFonts.archivoBlack(),
            ),
            const SizedBox(height: 16.0),
            AutoSizeText(
                "Don't worry sometimes people can forget too. enter your email and we will send you a password reset link",
                style: GoogleFonts.aBeeZee(
                    color: kGrey, fontWeight: FontWeight.w400)),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.direct),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(width: 1, color: kGrey)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(width: 1, color: kGrey)),
                  labelText: 'E-Mail',
                  labelStyle: GoogleFonts.aBeeZee(
                      color: kGrey, fontSize: 14, fontWeight: FontWeight.w400)),
            ),
            const SizedBox(height: 30.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.blueAccent)),
                onPressed: () {
                  Get.toNamed('/reset-password');
                },
                child: AutoSizeText(
                  'Submit',
                  style: GoogleFonts.archivoBlack(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
