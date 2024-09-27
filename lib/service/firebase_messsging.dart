import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutterapp/controller/auth_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class FirebaseMessagingSe {

  FirebaseMessagingSe._();

  static FirebaseMessagingSe fm = FirebaseMessagingSe._();

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;


  Future<void> requestPermission() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      await requestPermission();
    }

  }

  Future<void> gettoken() async {
    String? token = await firebaseMessaging.getToken();
    log(token!);
  }

}