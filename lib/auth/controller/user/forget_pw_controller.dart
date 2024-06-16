import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/auth/controller/user/network_manager.dart';
import 'package:textspeech/auth/controller/sign_up_controller.dart';
import 'package:textspeech/auth/reset_password.dart';
import 'package:textspeech/auth/controller/auth_controller.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordKey = GlobalKey<FormState>();

  // send reset password email
  sendPasswordResetEmail() async {
    try {
      showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => PopScope(
          canPop: false,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: const AnimationLoader(
              text: 'Memproses permintaan Anda...',
              animation: 'assets/animations/141594-animation-of-docer.json',
              showAction: false,
            ),
          ),
        ),
      );

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        Navigator.of(Get.overlayContext!).pop();
        return;
      }

      if (!forgetPasswordKey.currentState!.validate()) {
        Navigator.of(Get.overlayContext!).pop();
        return;
      }

      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      Navigator.of(Get.overlayContext!).pop();

      Get.snackbar(
        'Email Sent',
        'Email Link Sent to Reset your password'.tr,
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

      Get.to(() => ResetPassword(
            email: email.text.trim(),
          ));
    } catch (e) {
      Navigator.of(Get.overlayContext!).pop();
      Get.snackbar(
        'Oh Snap!',
        e.toString(),
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: Colors.red.shade600,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
        icon: const Icon(
          Iconsax.warning_2,
          color: Colors.white,
        ),
      );
    }
  }

  // resend reset pw
  resendPasswordResetEmail(String email) async {
    try {
      showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => PopScope(
          canPop: false,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: const AnimationLoader(
              text: 'Memproses permintaan Anda...',
              animation: 'assets/animations/141594-animation-of-docer.json',
              showAction: false,
            ),
          ),
        ),
      );

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        Navigator.of(Get.overlayContext!).pop();
        return;
      }

      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      Navigator.of(Get.overlayContext!).pop();

      Get.snackbar(
        'Email Sent',
        'Email Link Sent to Reset your password'.tr,
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
      Navigator.of(Get.overlayContext!).pop();
      Get.snackbar(
        'Oh Snap!',
        e.toString(),
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: Colors.red.shade600,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
        icon: const Icon(
          Iconsax.warning_2,
          color: Colors.white,
        ),
      );
    }
  }
}
