// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDBHUV0tQ5RorqJIQj6p_lJS2fZQ-FAL2c',
    appId: '1:191540317204:android:d8e5b6add0f7d03da76b01',
    messagingSenderId: '191540317204',
    projectId: 'teste-flutter-bc3a1',
    storageBucket: 'teste-flutter-bc3a1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyComAspeNqYqpk7RtGMk5BHjyu096CTK-g',
    appId: '1:191540317204:ios:dea828574ffbdb4ca76b01',
    messagingSenderId: '191540317204',
    projectId: 'teste-flutter-bc3a1',
    storageBucket: 'teste-flutter-bc3a1.appspot.com',
    iosClientId: '191540317204-7bubn2f0f7ri2drb5k2cb2pdsqf0p89v.apps.googleusercontent.com',
    iosBundleId: 'com.samuel.testeFramework',
  );
}
