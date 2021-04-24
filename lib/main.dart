import 'package:askimam/app_module.dart';
import 'package:askimam/app_widget.dart';
import 'package:askimam/common/connection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

Future<void> main() async {
  await Firebase.initializeApp();
  await _requestMessagingPermissions();

  runApp(ModularApp(module: AppModule(apiUrl), child: AppWidget()));
}

Future<void> _requestMessagingPermissions() async {
  final messaging = FirebaseMessaging.instance;

  final settings = await messaging.requestPermission();

  print('User granted permission: ${settings.authorizationStatus}');
}
