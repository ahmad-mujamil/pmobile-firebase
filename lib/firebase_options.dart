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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAbzOjqSM4JX5XUZ5e79M92MzrvXBv3R0Q',
    appId: '1:648038397100:android:1f79628f08d1c68f781b09',
    messagingSenderId: '648038397100',
    projectId: 'mobile3-firebase',
    storageBucket: 'mobile3-firebase.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBgQsX6id0IxIqXdbhfuPpWIU10K7QGsHo',
    appId: '1:648038397100:ios:c5683e5c95d4bda3781b09',
    messagingSenderId: '648038397100',
    projectId: 'mobile3-firebase',
    storageBucket: 'mobile3-firebase.appspot.com',
    iosBundleId: 'com.example.mob3Jamil002UtsXt',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBgQsX6id0IxIqXdbhfuPpWIU10K7QGsHo',
    appId: '1:648038397100:ios:c5683e5c95d4bda3781b09',
    messagingSenderId: '648038397100',
    projectId: 'mobile3-firebase',
    storageBucket: 'mobile3-firebase.appspot.com',
    iosBundleId: 'com.example.mob3Jamil002UtsXt',
  );
}