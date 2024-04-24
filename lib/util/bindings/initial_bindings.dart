import 'package:get/get.dart';
import 'package:textspeech/services/firebase_storage_service.dart';
import 'package:textspeech/util/auth_controller.dart';
import 'package:textspeech/util/theme_controller.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.put(ThemeController());
    Get.put(FirebaseStorageService());
  }
}
