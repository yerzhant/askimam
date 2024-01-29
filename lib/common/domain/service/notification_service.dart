import 'package:askimam/chat/domain/model/notification.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:dartz/dartz.dart';

abstract class NotificationService {
  Future<Either<Rejection, String>> getFcmToken();
  Stream<String> tokenRefreshes();
  Stream<Notification> notifications();
}
