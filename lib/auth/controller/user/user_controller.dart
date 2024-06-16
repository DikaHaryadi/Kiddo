import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textspeech/auth/controller/user/network_manager.dart';
import 'package:textspeech/auth/controller/sign_up_controller.dart';
import 'package:textspeech/repository/user_repo.dart';
import 'package:textspeech/auth/re_auth_user_login.dart';
import 'package:textspeech/models/user_model.dart';
import 'package:textspeech/interface/intro/introduction_screen.dart';
import 'package:textspeech/auth/controller/auth_controller.dart';

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

  Future<void> saveUserRecord(
      UserCredential? userCredential, String token) async {
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
              profilePicture: userCredential.user!.photoURL ?? '',
              token: token);
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
    }
  }

  // Hapus Akun warning popup
  void deleteAccountWarningPopUp() {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(16.0),
        title: 'Hapus Akun'.tr,
        middleText:
            'Apakah Anda yakin ingin menghapus akun Anda secara permanen? Tindakan ini tidak dapat dibatalkan dan semua data Anda akan dihapus secara permanen',
        confirm: ElevatedButton(
          onPressed: () async => deleUserAccount(),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              side: const BorderSide(color: Colors.red)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text('Hapus'.tr),
          ),
        ),
        cancel: OutlinedButton(
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: Text('Cancel'.tr)));
  }

  // delete user account
  void deleUserAccount() async {
    try {
      showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => PopScope(
          canPop: false,
          child: AnimationLoader(
            text: 'Prosess...'.tr,
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
          Get.snackbar(
            'Atention',
            'Your account has been deleted',
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
        } else if (provider == 'password') {
          Navigator.of(Get.overlayContext!).pop();
          Get.to(() => const ReAuthForm());
        }
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
            text: 'Prosess...',
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
      Get.snackbar(
        'Atention',
        'Your account has been deleted',
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

  // Upload profile image
  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (image != null) {
        imageUploading.value = true;

        // Check if last profile picture update is available
        final lastUpdateTimestamp =
            await userRepo.getLastProfileUpdateTimestamp();

        if (lastUpdateTimestamp == null ||
            DateTime.now().difference(lastUpdateTimestamp).inDays >= 7) {
          // If there is no last update timestamp or it's been more than 7 days, allow the update
          final imageUrl =
              await userRepo.uploadImage('Users/${user.value.id}/', image);

          // Store the image URL in Firebase Firestore or Realtime Database
          await userRepo.updateSingleField({'ProfilePicture': imageUrl});

          // Update User Image Record locally
          user.value.profilePicture = imageUrl;
          await userRepo.setLastProfileUpdateTimestamp(DateTime.now());
          Get.snackbar(
            'Selamat',
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
        } else {
          // If it's within 7 days, show a message indicating when the next update can be done
          final daysRemaining =
              7 - DateTime.now().difference(lastUpdateTimestamp).inDays;
          Get.snackbar(
            'Oops!',
            'You can only update your profile picture in $daysRemaining days.',
            maxWidth: 600,
            isDismissible: true,
            shouldIconPulse: true,
            colorText: Colors.white,
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
            margin: const EdgeInsets.all(10),
            icon: const Icon(Iconsax.warning_2, color: Colors.white),
          );
        }

        user.refresh();
      }
    } catch (e) {
      // Show error message
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
