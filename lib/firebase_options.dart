// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAFy6rHww7PaD2_In3tY762BAmBnABwEgc',
    appId: '1:230372855938:web:e8ecd318fe183d5e44249b',
    messagingSenderId: '230372855938',
    projectId: 'chat-app-3e7a6',
    authDomain: 'chat-app-3e7a6.firebaseapp.com',
    storageBucket: 'chat-app-3e7a6.appspot.com',
    measurementId: 'G-1X2E9RXTLS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDhcAIYV2y02Njvd8lQ50qZSOKlGgOxUak',
    appId: '1:230372855938:android:6a6bf0695abb3ab944249b',
    messagingSenderId: '230372855938',
    projectId: 'chat-app-3e7a6',
    storageBucket: 'chat-app-3e7a6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA78uDzAkdMFveoGiBjqYl_bvO2GBXs3aA',
    appId: '1:230372855938:ios:94dfca47c3904af444249b',
    messagingSenderId: '230372855938',
    projectId: 'chat-app-3e7a6',
    storageBucket: 'chat-app-3e7a6.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA78uDzAkdMFveoGiBjqYl_bvO2GBXs3aA',
    appId: '1:230372855938:ios:2d5924f74f86689444249b',
    messagingSenderId: '230372855938',
    projectId: 'chat-app-3e7a6',
    storageBucket: 'chat-app-3e7a6.appspot.com',
    iosBundleId: 'com.example.chatApp.RunnerTests',
  );
}
