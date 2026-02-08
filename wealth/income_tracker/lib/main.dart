import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initializeFirebaseSafely();
  runApp(const MyApp());
}

Future<void> _initializeFirebaseSafely() async {
  try {
    if (kIsWeb) {
      final options = _webFirebaseOptionsFromEnvironment();
      if (options == null) {
        debugPrint(
          'Firebase not initialized on web: missing --dart-define values '
          '(FIREBASE_WEB_API_KEY, FIREBASE_WEB_APP_ID, FIREBASE_WEB_MESSAGING_SENDER_ID, FIREBASE_WEB_PROJECT_ID).',
        );
        return;
      }

      await Firebase.initializeApp(options: options);
      return;
    }

    await Firebase.initializeApp();
  } catch (error) {
    debugPrint('Firebase initialization skipped: $error');
  }
}

FirebaseOptions? _webFirebaseOptionsFromEnvironment() {
  const apiKey = String.fromEnvironment('FIREBASE_WEB_API_KEY');
  const appId = String.fromEnvironment('FIREBASE_WEB_APP_ID');
  const messagingSenderId = String.fromEnvironment(
    'FIREBASE_WEB_MESSAGING_SENDER_ID',
  );
  const projectId = String.fromEnvironment('FIREBASE_WEB_PROJECT_ID');

  if (apiKey.isEmpty ||
      appId.isEmpty ||
      messagingSenderId.isEmpty ||
      projectId.isEmpty) {
    return null;
  }

  const authDomain = String.fromEnvironment('FIREBASE_WEB_AUTH_DOMAIN');
  const storageBucket = String.fromEnvironment('FIREBASE_WEB_STORAGE_BUCKET');
  const measurementId = String.fromEnvironment('FIREBASE_WEB_MEASUREMENT_ID');
  const iosBundleId = String.fromEnvironment('FIREBASE_WEB_IOS_BUNDLE_ID');

  return FirebaseOptions(
    apiKey: apiKey,
    appId: appId,
    messagingSenderId: messagingSenderId,
    projectId: projectId,
    authDomain: authDomain.isEmpty ? null : authDomain,
    storageBucket: storageBucket.isEmpty ? null : storageBucket,
    measurementId: measurementId.isEmpty ? null : measurementId,
    iosBundleId: iosBundleId.isEmpty ? null : iosBundleId,
  );
}
