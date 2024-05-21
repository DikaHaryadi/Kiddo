import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  Map<String, dynamic> payload = {};

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments;

    // Background and terminated state
    if (data is RemoteMessage) {
      payload = data.data;
    }

    // Foreground state
    if (data is NotificationResponse) {
      payload = jsonDecode(data.payload!);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Message Details'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Payload:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                payload.toString(),
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
