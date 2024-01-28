import 'package:askimam/app_module.dart';
import 'package:askimam/app_widget.dart';
import 'package:askimam/common/connection.dart';
import 'package:askimam/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.requestPermission();

  runApp(ModularApp(module: AppModule(apiUrl), child: const AppWidget()));
}
