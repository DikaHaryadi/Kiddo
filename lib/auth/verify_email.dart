import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textspeech/auth/controller/verify_email_controller.dart';
import 'package:textspeech/util/etc/app_colors.dart';
import 'package:textspeech/auth/controller/auth_controller.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => AuthenticationRepository.instance.logOut(),
              icon: const Icon(Icons.close))
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
            child: Column(
              children: [
                Image(
                  image: const AssetImage('assets/images/verify.png'),
                  width: MediaQuery.of(context).size.width * 0.6,
                ),
                const SizedBox(height: 16.0),
                AutoSizeText(
                  'Verify your email address!',
                  textAlign: TextAlign.center,
                  minFontSize: 20,
                  maxFontSize: 22,
                  style: GoogleFonts.archivoBlack(),
                ),
                const SizedBox(height: 16.0),
                AutoSizeText(
                  email ?? '',
                  textAlign: TextAlign.center,
                  minFontSize: 16,
                  maxFontSize: 18,
                  style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                AutoSizeText(
                  'Congratulations! Your Account Awaits: Verify Your Email to Start Learning with us',
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
                    onPressed: () => controller.checkEmailVerificationStatus(),
                    child: AutoSizeText(
                      'Continue',
                      style: GoogleFonts.archivoBlack(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () => controller.sendEmailVerification(),
                      child: AutoSizeText(
                        'Resend Email',
                        style: GoogleFonts.archivoBlack(color: kGrey),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
