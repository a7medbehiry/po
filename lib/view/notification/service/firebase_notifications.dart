import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pet_app/view/notification/notification_view.dart';
import 'package:pet_app/view/notification/widgets/custom_snack_bar.dart';

class FirebaseNotifications {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Store notifications in a list
  final List<RemoteMessage> _messages = [];

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    String? fcmToken = await _firebaseMessaging.getToken();
    log("FCM Token: $fcmToken");

    // Save the FCM token to shared preferences
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('fcmToken', fcmToken ?? '');

    handleBackgroundNotifications();
  }

  void handleMessage(RemoteMessage message) {
    // Add message to list
    _messages.add(message);

    Navigator.push(
      navigatorKey.currentState!.context,
      MaterialPageRoute(
        builder: (context) => NotificationView(
          messages: _messages, // Pass all messages
        ),
      ),
    );
  }

  Future<void> handleBackgroundNotifications() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        handleMessage(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(message);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        log("Title: ${message.notification!.title}");
        log("Body: ${message.notification!.body}");
        SnackBarManager.showSnackBarNotification(message.notification?.body);
        handleMessage(message); // Handle incoming messages
      }
    });
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    log('Handling a background message: ${message.messageId}');
    // Handle background message here
  }
}
