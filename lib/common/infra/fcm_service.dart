import 'dart:io';

import 'package:askimam/chat/domain/model/notification.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/common/domain/service/notification_service.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FcmService implements NotificationService {
  @override
  Future<Either<Rejection, String>> getFcmToken() async {
    try {
      if (!kIsWeb && Platform.isIOS) {
        final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        if (apnsToken == null) {
          return left(Rejection('APNs token is null'));
        }
      }

      final token = await FirebaseMessaging.instance.getToken(
        vapidKey:
            'BIXzssvzuFUsSssjJT2LJFxGD_z_M0ESO3I7lenS5LEWp2x0P1aBPCAqyXro12Kxk-n7qZuiV5nhOCO2m1QMT3A',
      );

      if (token == null) return left(Rejection('FCM token is unavailable.'));

      return right(token);
    } on Exception catch (e) {
      return left(e.asRejection());
    }
  }

  @override
  Stream<String> tokenRefreshes() => FirebaseMessaging.instance.onTokenRefresh;

  @override
  Stream<Notification> notifications() => FirebaseMessaging.onMessage.map(
        (msg) => Notification(
          recievedOn: DateTime.now(),
          title: msg.notification?.title,
          body: msg.notification?.body,
        ),
      );
}
