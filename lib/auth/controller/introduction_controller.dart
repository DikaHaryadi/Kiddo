import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/auth/controller/user/network_manager.dart';
import 'package:textspeech/auth/controller/sign_up_controller.dart';
import 'package:textspeech/auth/controller/user/user_controller.dart';
import 'package:textspeech/auth/controller/auth_controller.dart';
import 'package:textspeech/services/notification.dart';

class IntroductionController extends GetxController {
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFromKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());
  final firebaseNotification = Get.put(FirebaseNotification());

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? "";
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? "";
    super.onInit();
  }

  // Email and password signin
  Future<void> emailAndPasswordSignIn() async {
    try {
      showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (context) => const PopScope(
            canPop: false,
            child: AnimationLoader(
                text: 'Mohon ditunggu...',
                animation: 'assets/animations/141594-animation-of-docer.json',
                showAction: false)),
      );

      // check Internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        Navigator.of(Get.overlayContext!).pop();
        return;
      }

      // save data if Ingat Saya is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // login user using email and pw authentification
      // final userCredential =
      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());
      // remove loadder
      Navigator.of(Get.overlayContext!).pop();
      //navigate
      AuthenticationRepository.instance.navigateToIntroduction();
    } catch (e) {
      Navigator.of(Get.overlayContext!).pop();
      Get.snackbar(
        'Oh God',
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

  // Google SignIn Auth
  Future<void> googleSignIn() async {
    try {
      showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (context) => const PopScope(
            canPop: false,
            child: AnimationLoader(
                text: 'Mohon ditunggu...',
                animation: 'assets/animations/141594-animation-of-docer.json',
                showAction: false)),
      );

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        Navigator.of(Get.overlayContext!).pop();
        return;
      }
      // google authentification
      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();
      final token = firebaseNotification.mToken.value;

      // save user data
      await userController.saveUserRecord(userCredentials, token);
      Navigator.of(Get.overlayContext!).pop();
      // navigate
      AuthenticationRepository.instance.navigateToIntroduction();
    } catch (e) {
      Navigator.of(Get.overlayContext!).pop();
      Get.snackbar(
        'Oh God',
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
      print('TERJADI ERROR SAAT LOGIN MENGGUNAKAN GOOGLE ACC: ${e.toString()}');
    }
  }
}
