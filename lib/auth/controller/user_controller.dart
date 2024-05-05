import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textspeech/auth/controller/network_manager.dart';
import 'package:textspeech/auth/controller/sign_up_controller.dart';
import 'package:textspeech/auth/controller/user_repo.dart';
import 'package:textspeech/auth/re_auth_user_login.dart';
import 'package:textspeech/auth/user_model.dart';
import 'package:textspeech/interface/introduction_screen.dart';
import 'package:textspeech/util/auth_controller.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepo = Get.put(UserRepository());

  final hidePassword = false.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepo.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      // First update Rx User and then check if user data is already stored. If not store new data
      await fetchUserRecord();

      if (user.value.id.isEmpty) {
        if (userCredential != null) {
          final nameParts =
              UserModel.nameParts(userCredential.user!.displayName ?? '');
          final username = UserModel.generateUsername(
              userCredential.user!.displayName ?? '');

          // Map Data
          final user = UserModel(
              id: userCredential.user!.uid,
              firstName: nameParts[0],
              lastName:
                  nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
              username: username,
              email: userCredential.user!.email ?? '',
              profilePicture: userCredential.user!.photoURL ?? '');
          // save user data
          await userRepo.saveUserRecord(user);
        }
      }
    } catch (e) {
      Get.snackbar(
        'Oh Snap!',
        '',
        maxWidth: 600,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: Colors.orange,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
        icon: const Icon(Iconsax.warning_2, color: Colors.white),
      );
      print('google acc error$e');
    }
  }

  // delete account warning popup
  void deleteAccountWarningPopUp() {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(16.0),
        title: 'Delete Account',
        middleText:
            'Are you sure, you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently',
        confirm: ElevatedButton(
          onPressed: () async => deleUserAccount(),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              side: const BorderSide(color: Colors.red)),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text('Delete'),
          ),
        ),
        cancel: OutlinedButton(
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: const Text('Cancel')));
  }

  // delete user account
  void deleUserAccount() async {
    try {
      showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => const PopScope(
          canPop: false,
          child: AnimationLoader(
            text: 'Proccessing...',
            animation: 'assets/animations/141594-animation-of-docer.json',
            showAction: false,
          ),
        ),
      );

      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;

      if (provider.isNotEmpty) {
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          Navigator.of(Get.overlayContext!).pop();
          Get.offAll(() => const IntroductionScreen());
        }
      } else if (provider == 'password') {
        Navigator.of(Get.overlayContext!).pop();
        Get.to(() => const ReAuthForm());
      }
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

// Re authenticate before deleting account
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => const PopScope(
          canPop: false,
          child: AnimationLoader(
            text: 'Proccessing...',
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
      if (!reAuthFormKey.currentState!.validate()) {
        Navigator.of(Get.overlayContext!).pop();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
              verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      Navigator.of(Get.overlayContext!).pop();
      Get.offAll(() => const IntroductionScreen());
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

  // Upload profile image
  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        imageUploading.value = true;
        final imageUrl =
            await userRepo.uploadImage('Users/Images/Profile/', image);
        // update User Image Record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepo.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        user.refresh();

        Get.snackbar(
          'Congratulations',
          'Your Profile Image has been updated!',
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
      }
    } catch (e) {
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
    } finally {
      imageUploading.value = false;
    }
  }
}
