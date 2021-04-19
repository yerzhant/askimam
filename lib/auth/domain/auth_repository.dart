import 'package:askimam/auth/domain/authentication.dart';
import 'package:askimam/auth/domain/authentication_request.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Option<Rejection>> logout();
  Future<Either<Rejection, Authentication>> load();
  Future<Either<Rejection, Authentication>> login(
      AuthenticationRequest request);
}
