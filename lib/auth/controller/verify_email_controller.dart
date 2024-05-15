import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/auth/success_verify.dart';
import 'package:textspeech/auth/controller/auth_controller.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      Get.snackbar(
        'Email Sent',
        'Please check your inbox and verify your email.',
        maxWidth: 600,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: Colors.blueAccent,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(10),
        icon: const Icon(Iconsax.check, color: Colors.white),
      );
    } catch (e) {
      Get.snackbar(
        'Oh Snap!',
        e.toString(),
        maxWidth: 600,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: Colors.red.shade600,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
        icon: const Icon(Iconsax.warning_2, color: Colors.white),
      );
    }
  }

  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => SuccessVerify(
            image: 'assets/animations/72462-check-register.json',
            title: 'Your account successfully created!',
            subTitle:
                "Yeay! Welcome to the fun place to learn! Let's explore the world of learning together. Hopefully we can all become shining five stars on the Play Store with your support! 🌟",
            onPressed: () =>
                AuthenticationRepository.instance.navigateToIntroduction()));
      }
    });
  }

  // Manually check if email has verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => SuccessVerify(
          image: 'assets/animations/72462-check-register.json',
          title: 'Your account successfully created!',
          subTitle:
              "Yeay! Welcome to the fun place to learn! Let's explore the world of learning together. Hopefully we can all become shining five stars on the Play Store with your support!",
          onPressed: () =>
              AuthenticationRepository.instance.navigateToIntroduction()));
    }
  }
}
