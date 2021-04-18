// Mocks generated by Mockito 5.0.3 from annotations
// in askimam/test/auth/bloc/auth_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:askimam/auth/domain/auth_repository.dart' as _i3;
import 'package:askimam/auth/domain/authentication.dart' as _i6;
import 'package:askimam/auth/domain/authentication_request.dart' as _i7;
import 'package:askimam/common/domain/rejection.dart' as _i5;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

class _FakeOption<A> extends _i1.Fake implements _i2.Option<A> {}

class _FakeEither<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [AuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRepository extends _i1.Mock implements _i3.AuthRepository {
  MockAuthRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Option<_i5.Rejection>> logout() =>
      (super.noSuchMethod(Invocation.method(#logout, []),
              returnValue: Future.value(_FakeOption<_i5.Rejection>()))
          as _i4.Future<_i2.Option<_i5.Rejection>>);
  @override
  _i4.Future<_i2.Either<_i5.Rejection, _i6.Authentication>> load() =>
      (super.noSuchMethod(Invocation.method(#load, []),
              returnValue: Future.value(
                  _FakeEither<_i5.Rejection, _i6.Authentication>()))
          as _i4.Future<_i2.Either<_i5.Rejection, _i6.Authentication>>);
  @override
  _i4.Future<_i2.Either<_i5.Rejection, _i6.Authentication>> login(
          _i7.AuthenticationRequest? request) =>
      (super.noSuchMethod(Invocation.method(#login, [request]),
              returnValue: Future.value(
                  _FakeEither<_i5.Rejection, _i6.Authentication>()))
          as _i4.Future<_i2.Either<_i5.Rejection, _i6.Authentication>>);
}
