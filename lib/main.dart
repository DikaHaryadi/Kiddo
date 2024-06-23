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
import 'package:textspeech/controllers/language_controller.dart';
import 'package:textspeech/firebase_options.dart';
import 'package:textspeech/services/notification.dart';
import 'package:textspeech/util/etc/app_routes.dart';
import 'package:textspeech/auth/controller/auth_controller.dart';
import 'package:textspeech/util/bindings/initial_bindings.dart';
import 'package:textspeech/util/etc/dep_lang.dart';
import 'package:textspeech/util/etc/message_lang.dart';
import 'package:textspeech/util/etc/responsive.dart';
import 'package:textspeech/util/widgets/theme.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:textspeech/util/etc/dep_lang.dart' as dep;

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
  Map<String, Map<String, String>> languages = await dep.init();

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize('bb04cd3f-351c-4762-86ec-bdcb78227a25');
  OneSignal.Notifications.requestPermission(true);

  runApp(MyApp(
    navigatorKey: navigatorKey,
    languages: languages,
  ));
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final Map<String, Map<String, String>> languages;
  const MyApp({super.key, required this.navigatorKey, required this.languages});

  @override
  Widget build(BuildContext context) {
    String? screen;
    OneSignal.Notifications.addClickListener((event) {
      final data = event.notification.additionalData;
      screen = data?['screen'];
      if (screen != null) {
        navigatorKey.currentState?.pushNamed(screen!);
      }
    });

    return GetBuilder<LocalizationController>(
        builder: (localizationController) {
      return GetMaterialApp(
        themeMode: ThemeMode.light,
        theme: isMobile(context)
            ? AppTheme.lightTheme
            : AppTheme.lightDesktopTheme,
        debugShowCheckedModeBanner: false,
        locale: localizationController.locale,
        translations: MessageLang(languages: languages),
        fallbackLocale: Locale(AppLanguageConstant.languages[0].languageCode,
            AppLanguageConstant.languages[0].countryCode),
        getPages: AppRoutes.routes(),
        initialBinding: InitialBindings(),
        navigatorKey: navigatorKey,
      );
    });
  }
}
