import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/auth/controller/network_manager.dart';
import 'package:textspeech/auth/controller/sign_up_controller.dart';
import 'package:textspeech/auth/controller/user_controller.dart';
import 'package:textspeech/auth/controller/user_repo.dart';
import 'package:textspeech/interface/profile.dart';

class UpdateUsernameController extends GetxController {
  static UpdateUsernameController get insance => Get.find();

  final userName = TextEditingController();

  final userController = UserController.instance;
  final userRepo = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  Future<void> initializeNames() async {
    userName.text = userController.user.value.username;
  }

  Future<void> updateUserName() async {
    try {
      showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => const PopScope(
          canPop: false,
          child: AnimationLoader(
            text: 'We are processing your information..',
            animation: 'assets/animations/141594-animation-of-docer.json',
            showAction: false,
          ),
        ),
      );

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        Navigator.of(Get.overlayContext!).pop();
        return;
      }

      // Form validation
      if (!updateUserNameFormKey.currentState!.validate()) {
        Navigator.of(Get.overlayContext!).pop();
        return;
      }

      // update users firstname and lastname in firebase
      Map<String, dynamic> username = {
        'Username': userName.text.trim(),
      };
      await userRepo.updateSingleField(username);

      // Update Rx user value
      userController.user.value.username = userName.text.trim();

      Navigator.of(Get.overlayContext!).pop();

      Get.snackbar(
        'Congratulations',
        'Your account has been created! Verify email to continue.',
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

      Get.off(() => const ProfileScreen());
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