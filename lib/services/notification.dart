import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';

class FirebaseNotification extends GetxController {
  static FirebaseNotification get instance => Get.find();

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final navigatorKey = GlobalKey<NavigatorState>();
  RxString mToken = ''.obs;

  @override
  void onInit() {
    super.onInit();
    requestPermission();
    getToken();
    initInfo();
    setupInteractedMessage();
  }

  GlobalKey<NavigatorState> getNavigatorKey() {
    return navigatorKey;
  }

  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void getToken() async {
    try {
      String? token = await messaging.getToken();
      if (token != null) {
        mToken.value = token;
        update(); // Update the UI if necessary
        print('My Token: $token');
        saveTokenToFirestore();
      } else {
        print('Failed to get FCM token');
      }
    } catch (e) {
      print('Error fetching FCM token: $e');
    }
  }

  void saveTokenToFirestore() async {
    try {
      // Replace UserModel with your actual user data model
      UserModel user = UserModel.empty();
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.id)
          .set({'Token': mToken.value}, SetOptions(merge: true));
      print('FCM token saved successfully');
    } catch (e) {
      print('Error saving FCM token: $e');
    }
  }

  static Future<void> initInfo() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotifTapped,
        onDidReceiveBackgroundNotificationResponse: onNotifTapped);
  }

  static void onNotifTapped(NotificationResponse notificationResponse) {}

  void setupInteractedMessage() {
    // Handle when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        showNotification(message);
      }
    });

    // Handle when the app is opened from terminated state or background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        print('Notification tapped while app was in background or terminated');
        navigatorKey.currentState!.pushNamed('/message', arguments: message);
      }
    });

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print("Handling a background message: ${message.messageId}");
    // Handle background message here
  }

  void showNotification(RemoteMessage message) {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }
}
