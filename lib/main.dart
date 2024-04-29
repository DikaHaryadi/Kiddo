import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:textspeech/util/app_routes.dart';
import 'package:textspeech/util/bindings/initial_bindings.dart';

// void main() async {
//   final WidgetsBinding widgetsBinding =
//       WidgetsFlutterBinding.ensureInitialized();
//   InitialBindings().dependencies();
//   MobileAds.instance.initialize();
//   await GetStorage.init();
//   FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
//   await initializeDateFormatting('en_US', null);
//   await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//   await FirebaseAppCheck.instance.activate();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
//       .then((FirebaseApp value) => Get.put(AuthController()));
//   runApp(const MyApp());
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase
  await Firebase.initializeApp();

  // Inisialisasi Dependency Injection
  InitialBindings().dependencies();

  // Inisialisasi lainnya
  MobileAds.instance.initialize();
  await GetStorage.init();
  await initializeDateFormatting('en_US', null);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await FirebaseAppCheck.instance.activate();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.routes(),
    );
  }
}
