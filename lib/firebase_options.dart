// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB1QvnUM173smQTdtOckyZt0yc-PwKghfo',
    appId: '1:715921147822:web:7f620edd0aa8e7f985ea3f',
    messagingSenderId: '715921147822',
    projectId: 'flutterapapp',
    authDomain: 'flutterapapp.firebaseapp.com',
    storageBucket: 'flutterapapp.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCVFjP5D1ptsdKkvjIecwe2Otanszurs18',
    appId: '1:715921147822:android:112dfdbd0651fabd85ea3f',
    messagingSenderId: '715921147822',
    projectId: 'flutterapapp',
    storageBucket: 'flutterapapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB7Q4iGVPhaaxbUhDLsme0ViZVHdtuXQ5I',
    appId: '1:715921147822:ios:ae18d712148058d185ea3f',
    messagingSenderId: '715921147822',
    projectId: 'flutterapapp',
    storageBucket: 'flutterapapp.appspot.com',
    iosBundleId: 'com.example.flutterapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB7Q4iGVPhaaxbUhDLsme0ViZVHdtuXQ5I',
    appId: '1:715921147822:ios:ae18d712148058d185ea3f',
    messagingSenderId: '715921147822',
    projectId: 'flutterapapp',
    storageBucket: 'flutterapapp.appspot.com',
    iosBundleId: 'com.example.flutterapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB1QvnUM173smQTdtOckyZt0yc-PwKghfo',
    appId: '1:715921147822:web:1a8cfcbf901e565b85ea3f',
    messagingSenderId: '715921147822',
    projectId: 'flutterapapp',
    authDomain: 'flutterapapp.firebaseapp.com',
    storageBucket: 'flutterapapp.appspot.com',
  );
}
