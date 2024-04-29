import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/auth/controller/network_manager.dart';
import 'package:textspeech/auth/controller/sign_up_controller.dart';
import 'package:textspeech/interface/homepage.dart';
import 'package:textspeech/util/auth_controller.dart';

// class IntroductionController extends GetxController {
//   final rememberMe = false.obs;
//   final hidePassword = true.obs;
//   final localStorage = GetStorage();
//   final email = TextEditingController();
//   final password = TextEditingController();
//   GlobalKey<FormState> loginFromKey = GlobalKey<FormState>();

//   @override
//   void onInit() {
//     email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? "";
//     password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? "";
//     super.onInit();
//   }

//   // Email and password signin
//   Future<void> emailAndPasswordSignIn() async {
//     try {
//       showDialog(
//         context: Get.overlayContext!,
//         barrierDismissible: false,
//         builder: (context) => const PopScope(
//             canPop: false,
//             child: AnimationLoader(
//                 text: 'Logging you in..',
//                 animation: 'assets/animations/141594-animation-of-docer.json',
//                 showAction: true)),
//       );

//       // check Internet connectivity
//       final isConnected = await NetworkManager.instance.isConnected();
//       if (!isConnected) {
//         Navigator.of(Get.overlayContext!).pop();
//         return;
//       }

//       // save data if remember me is selected
//       if (rememberMe.value) {
//         localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
//         localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
//       }

//       // login user using email and pw authentification
//       // final userCredential =
//       await Get.find<AuthController>()
//           .loginWithEmailAndPassword(email.text.trim(), password.text.trim());
//       // remove loadder
//       Navigator.of(Get.overlayContext!).pop();
//       //navigate
//       Get.find<AuthController>().navigateToIntroduction();
//     } catch (e) {
//       Navigator.of(Get.overlayContext!).pop();
//       Get.snackbar(
//         'Oh God',
//         e.toString(),
//         maxWidth: 600,
//         isDismissible: true,
//         shouldIconPulse: true,
//         colorText: Colors.white,
//         backgroundColor: Colors.red.shade600,
//         snackPosition: SnackPosition.BOTTOM,
//         duration: const Duration(seconds: 3),
//         margin: const EdgeInsets.all(20),
//         icon: const Icon(Iconsax.warning_2, color: Colors.white),
//       );
//     }
//   }
// }

class IntroductionController extends GetxController {
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? "";
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? "";
    super.onInit();
  }

  Future<void> emailAndPasswordSignIn() async {
    try {
      if (!loginFormKey.currentState!.validate()) {
        // Form validation failed, do not proceed with login
        return;
      }

      showLoadingDialog();

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        hideLoadingDialog();
        // Show snackbar or alert indicating no internet connection
        return;
      }

      if (rememberMe.value) {
        saveCredentials();
      }

      await loginUser();

      hideLoadingDialog();
      // Navigate to home screen after successful login
      Get.offAll(() => const HomePage());
    } catch (e) {
      hideLoadingDialog();
      showErrorSnackbar(e);
    }
  }

  void showLoadingDialog() {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (context) => const PopScope(
        canPop: false,
        child: AnimationLoader(
          text: 'Logging you in..',
          animation: 'assets/animations/141594-animation-of-docer.json',
          showAction: true,
        ),
      ),
    );
  }

  void hideLoadingDialog() {
    Navigator.of(Get.overlayContext!).pop();
  }

  void saveCredentials() {
    localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
    localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
  }

  Future<void> loginUser() async {
    await Get.find<AuthController>()
        .loginWithEmailAndPassword(email.text.trim(), password.text.trim());
  }

  void showErrorSnackbar(dynamic error) {
    Get.snackbar(
      'Oh God',
      error.toString(),
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
