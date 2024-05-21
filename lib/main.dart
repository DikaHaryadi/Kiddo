import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:textspeech/firebase_options.dart';
import 'package:textspeech/services/notification.dart';
import 'package:textspeech/util/etc/app_routes.dart';
import 'package:textspeech/auth/controller/auth_controller.dart';
import 'package:textspeech/util/bindings/initial_bindings.dart';
import 'package:textspeech/util/widgets/theme.dart';

void main() async {
  final WidgetsBinding widgetBinding =
      WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);

  // Inisialisasi Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  // Inisialisasi lainnya
  MobileAds.instance.initialize();
  await initializeDateFormatting('en_US', null);
  await FirebaseMessaging.instance.getInitialMessage();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await FirebaseAppCheck.instance.activate();

  // Inisialisasi FirebaseNotification
  Get.put(FirebaseNotification());

  // Mendapatkan navigatorKey dari FirebaseNotification
  final navigatorKey = FirebaseNotification.instance.getNavigatorKey();

  runApp(MyApp(navigatorKey: navigatorKey));
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const MyApp({super.key, required this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.routes(),
      initialBinding: InitialBindings(),
      navigatorKey: navigatorKey,
    );
  }
}
