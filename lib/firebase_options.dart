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
    apiKey: 'AIzaSyCNTZ22D9IavrJ0NCKfSEJu_EISAykcGsE',
    appId: '1:976541725053:web:e5d695604eb8ba9b411c14',
    messagingSenderId: '976541725053',
    projectId: 'spotifyapp-88eae',
    authDomain: 'spotifyapp-88eae.firebaseapp.com',
    storageBucket: 'spotifyapp-88eae.appspot.com',
    measurementId: 'G-M582YZ1F45',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBIeTlxRhbVhPynsX4JqG9v_dS51UP56fc',
    appId: '1:976541725053:android:62f415a0187c33cc411c14',
    messagingSenderId: '976541725053',
    projectId: 'spotifyapp-88eae',
    storageBucket: 'spotifyapp-88eae.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC7SbHAQeZ8kzjhJheW8t8Dbob8xIdSPt4',
    appId: '1:976541725053:ios:82d695294c8c4c2d411c14',
    messagingSenderId: '976541725053',
    projectId: 'spotifyapp-88eae',
    storageBucket: 'spotifyapp-88eae.appspot.com',
    iosBundleId: 'com.nitedev.spotify',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC7SbHAQeZ8kzjhJheW8t8Dbob8xIdSPt4',
    appId: '1:976541725053:ios:82d695294c8c4c2d411c14',
    messagingSenderId: '976541725053',
    projectId: 'spotifyapp-88eae',
    storageBucket: 'spotifyapp-88eae.appspot.com',
    iosBundleId: 'com.nitedev.spotify',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCNTZ22D9IavrJ0NCKfSEJu_EISAykcGsE',
    appId: '1:976541725053:web:8cfb9dcf6ba4994d411c14',
    messagingSenderId: '976541725053',
    projectId: 'spotifyapp-88eae',
    authDomain: 'spotifyapp-88eae.firebaseapp.com',
    storageBucket: 'spotifyapp-88eae.appspot.com',
    measurementId: 'G-P3LK35XQEM',
  );
}
