import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyCzdrHsnQfn9OtExDKOFXpeQd9VcMIIYWo',
    appId: '1:115124468211:web:aa65850d320321d9403a86',
    messagingSenderId: '115124468211',
    projectId: 'madhk-55157',
    authDomain: 'madhk-55157.firebaseapp.com',
    storageBucket: 'madhk-55157.firebasestorage.app',
    measurementId: 'G-VDTR8S0NJW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCzdrHsnQfn9OtExDKOFXpeQd9VcMIIYWo',
    appId: '1:115124468211:web:aa65850d320321d9403a86',
    messagingSenderId: '115124468211',
    projectId: 'madhk-55157',
    storageBucket: 'madhk-55157.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCzdrHsnQfn9OtExDKOFXpeQd9VcMIIYWo',
    appId: '1:115124468211:web:aa65850d320321d9403a86',
    messagingSenderId: '115124468211',
    projectId: 'madhk-55157',
    storageBucket: 'madhk-55157.firebasestorage.app',
    iosClientId: 'YOUR_IOS_CLIENT_ID',
    iosBundleId: 'YOUR_IOS_BUNDLE_ID',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCzdrHsnQfn9OtExDKOFXpeQd9VcMIIYWo',
    appId: '1:115124468211:web:aa65850d320321d9403a86',
    messagingSenderId: '115124468211',
    projectId: 'madhk-55157',
    storageBucket: 'madhk-55157.firebasestorage.app',
    iosClientId: 'YOUR_MACOS_CLIENT_ID',
    iosBundleId: 'YOUR_MACOS_BUNDLE_ID',
  );
}
