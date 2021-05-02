import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/common/domain/service/notification_service.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FcmService implements NotificationService {
  @override
  Future<Either<Rejection, String>> getFcmToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();

      if (token == null) return left(Rejection('FCM token is unavailable.'));

      return right(token);
    } on Exception catch (e) {
      return left(e.asRejection());
    }
  }
}
