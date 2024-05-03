import 'package:get/get.dart';
import 'package:textspeech/auth/controller/network_manager.dart';
import 'package:textspeech/services/firebase_storage_service.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    // Get.put(SignupController());
    Get.put(FirebaseStorageService());
    Get.put(NetworkManager());
    // Get.put(UserRepository());
    // Get.put(VerifyEmailController());
    // Get.put(IntroductionController());
    // Get.put(UserController());
  }
}
