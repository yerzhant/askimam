import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/auth/domain/model/login_request.dart';
import 'package:askimam/auth/domain/model/logout_request.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Option<Rejection>> logout(LogoutRequest request);
  Future<Either<Rejection, Authentication>> load();
  Future<Either<Rejection, Authentication>> login(LoginRequest request);
}
