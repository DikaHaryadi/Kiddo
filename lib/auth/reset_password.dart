import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textspeech/auth/controller/forget_pw_controller.dart';
import 'package:textspeech/util/app_colors.dart';

class ResetPassword extends StatelessWidget {
  final String email;
  const ResetPassword({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.close))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 24, right: 24, left: 24, top: 16),
          child: Column(
            children: [
              Image(
                image: const AssetImage('assets/images/success_verify.png'),
                width: MediaQuery.of(context).size.width * 0.6,
              ),
              const SizedBox(height: 16.0),
              AutoSizeText(
                email,
                textAlign: TextAlign.center,
                minFontSize: 20,
                maxFontSize: 22,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16.0),
              AutoSizeText(
                'Password Reset Email Sent',
                textAlign: TextAlign.center,
                minFontSize: 20,
                maxFontSize: 22,
                style: GoogleFonts.archivoBlack(),
              ),
              const SizedBox(height: 16.0),
              AutoSizeText(
                "Your Account Security is Our Primary! We've Sent You a Secure Link to Safety Change Your Password and Keep Your Account Proctected",
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
                  onPressed: () => Get.offAllNamed('/introduction'),
                  child: AutoSizeText(
                    'Continue',
                    style: GoogleFonts.archivoBlack(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.blueAccent, width: 1),
                  ),
                  onPressed: () => ForgetPasswordController.instance
                      .resendPasswordResetEmail(email),
                  child: AutoSizeText(
                    'Resend Email',
                    style: GoogleFonts.archivoBlack(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
