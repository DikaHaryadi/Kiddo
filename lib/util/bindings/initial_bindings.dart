import 'package:get/get.dart';
import 'package:textspeech/auth/controller/introduction_controller.dart';
import 'package:textspeech/auth/controller/network_manager.dart';
import 'package:textspeech/auth/controller/sign_up_controller.dart';
import 'package:textspeech/auth/controller/user_repo.dart';
import 'package:textspeech/auth/controller/verify_email_controller.dart';
import 'package:textspeech/services/firebase_storage_service.dart';
import 'package:textspeech/util/auth_controller.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(SignupController());
    Get.put(FirebaseStorageService());
    Get.put(NetworkManager());
    Get.put(UserRepository());
    Get.put(VerifyEmailController());
    Get.put(IntroductionController());
  }
}
