// TODO: to be implemented
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:dartz/dartz.dart';

abstract class NotificationService {
  Future<Either<Rejection, String>> getFcmToken();
}
