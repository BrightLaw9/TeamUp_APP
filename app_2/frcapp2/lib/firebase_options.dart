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
    apiKey: 'AIzaSyB8mwr9bntlDyWGmRiCfNUWEz6c8S1WnSU',
    appId: '1:223884308113:web:3ea460dc13585951149930',
    messagingSenderId: '223884308113',
    projectId: 'frcapp-ace4a',
    authDomain: 'frcapp-ace4a.firebaseapp.com',
    storageBucket: 'frcapp-ace4a.appspot.com',
    measurementId: 'G-F637BG27SN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAXHdYQABAe1LC7DcJyYTEEzcjhyK493s0',
    appId: '1:223884308113:android:4ebca6365f9ac4d8149930',
    messagingSenderId: '223884308113',
    projectId: 'frcapp-ace4a',
    storageBucket: 'frcapp-ace4a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBah7-uqlnPVIDG1E5aIOpK2BHmbwYzIkY',
    appId: '1:223884308113:ios:7522580ebe2ee9e0149930',
    messagingSenderId: '223884308113',
    projectId: 'frcapp-ace4a',
    storageBucket: 'frcapp-ace4a.appspot.com',
    iosClientId: '223884308113-5aal32dnf2ad8qdtph23jk3201pkknep.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApp1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBah7-uqlnPVIDG1E5aIOpK2BHmbwYzIkY',
    appId: '1:223884308113:ios:7522580ebe2ee9e0149930',
    messagingSenderId: '223884308113',
    projectId: 'frcapp-ace4a',
    storageBucket: 'frcapp-ace4a.appspot.com',
    iosClientId: '223884308113-5aal32dnf2ad8qdtph23jk3201pkknep.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApp1',
  );
}
