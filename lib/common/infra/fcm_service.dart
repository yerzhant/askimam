import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/common/domain/service/notification_service.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FcmService implements NotificationService {
  @override
  Future<Either<Rejection, String>> getFcmToken() async {
    try {
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
}
