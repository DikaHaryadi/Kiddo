import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:textspeech/auth/controller/network_manager.dart';
import 'package:textspeech/auth/controller/user_repo.dart';
import 'package:textspeech/auth/user_model.dart';
import 'package:textspeech/auth/verify_email.dart';
import 'package:textspeech/util/app_colors.dart';
import 'package:textspeech/util/auth_controller.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final privacyPolicy = true.obs;
  final hidePassword = true.obs;
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  void signup() async {
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
      if (!signupFormKey.currentState!.validate()) {
        Navigator.of(Get.overlayContext!).pop();
        return;
      }

      // Privacy policy check
      if (!privacyPolicy.value) {
        Get.snackbar(
          'Accept Privacy Policy',
          'In order to create an account, you must read and accept the Privacy Policy & Terms of Use',
          isDismissible: true,
          shouldIconPulse: true,
          colorText: Colors.white,
          backgroundColor: kSoftblue,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(20),
          icon: const Icon(
            Iconsax.warning_2,
            color: Colors.white,
          ),
        );
        Navigator.of(Get.overlayContext!).pop();
        return;
      }

      // Register user in Firebase Auth and save user data in Firebase Firestore
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // Save Auth user data in Firebase Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: userName.text.trim(),
        email: email.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Remove loader
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

      // Navigate to verify email
      Get.to(() => VerifyEmailScreen(
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
      print('error$e');
    }
  }
}

class AnimationLoader extends StatelessWidget {
  const AnimationLoader(
      {super.key,
      required this.text,
      required this.animation,
      required this.showAction,
      this.actionText,
      this.onActionPressed});

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(animation,
                width: MediaQuery.of(context).size.width * .8),
            const SizedBox(height: 16.0),
            AutoSizeText(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16.0),
            showAction
                ? SizedBox(
                    width: 250,
                    child: OutlinedButton(
                        onPressed: onActionPressed,
                        child: AutoSizeText(actionText ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(color: kWhite))),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
