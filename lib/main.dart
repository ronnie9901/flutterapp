
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/service/auth_service.dart';
import 'package:flutterapp/service/firebase_messsging.dart';
import 'package:flutterapp/theme/themeProvider.dart';
import 'package:flutterapp/view/homepage.dart';
import 'package:flutterapp/view/sign_in.dart';
import 'package:flutterapp/view/signup.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessagingSe.fm.requestPermission();
  await FirebaseMessagingSe.fm.gettoken();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ThemeController themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      getPages: [
        GetPage(name: '/', page: () =>(AuthService.authService.getCurrentUser()==null)?SignIn():Homepage()),
        GetPage(name: '/signup', page: () => SignUp()),
        GetPage(name: '/home', page: () => Homepage( ))
      ],

    );
  }
}
