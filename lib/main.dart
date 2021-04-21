import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> main() async {
  await Firebase.initializeApp();
  await _requestMessagingPermissions();
}

Future<void> _requestMessagingPermissions() async {
  final messaging = FirebaseMessaging.instance;

  final settings = await messaging.requestPermission();

  print('User granted permission: ${settings.authorizationStatus}');
}
