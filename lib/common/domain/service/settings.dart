import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:dartz/dartz.dart';

abstract class Settings {
  Future<Option<Rejection>> clearAuthentication();
  Future<Either<Rejection, Authentication>> getAuthentication();
  Future<Either<Rejection, Authentication>> setAuthentication(
      Authentication authentication);
}
