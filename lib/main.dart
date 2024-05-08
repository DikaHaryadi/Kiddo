import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:textspeech/firebase_options.dart';
import 'package:textspeech/util/app_routes.dart';
import 'package:textspeech/util/auth_controller.dart';
import 'package:textspeech/util/bindings/initial_bindings.dart';
import 'package:textspeech/util/theme.dart';

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
  final WidgetsBinding widgetBinding =
      WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);

  // Inisialisasi Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationRepository()));
  // Inisialisasi Dependency Injection
  // InitialBindings().dependencies();

  // Inisialisasi lainnya
  MobileAds.instance.initialize();
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
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.routes(),
      initialBinding: InitialBindings(),
    );
  }
}
