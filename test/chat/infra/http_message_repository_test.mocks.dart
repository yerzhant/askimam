// Mocks generated by Mockito 5.0.3 from annotations
// in askimam/test/chat/infra/http_message_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:askimam/common/domain/model/model.dart' as _i6;
import 'package:askimam/common/domain/model/rejection.dart' as _i5;
import 'package:askimam/common/domain/service/api_client.dart' as _i3;
import 'package:askimam/common/domain/service/notification_service.dart' as _i7;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

class _FakeEither<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeOption<A> extends _i1.Fake implements _i2.Option<A> {}

/// A class which mocks [ApiClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockApiClient extends _i1.Mock implements _i3.ApiClient {
  MockApiClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Rejection, M>> get<M extends _i6.Model>(
          String? suffix) =>
      (super.noSuchMethod(Invocation.method(#get, [suffix]),
              returnValue: Future.value(_FakeEither<_i5.Rejection, M>()))
          as _i4.Future<_i2.Either<_i5.Rejection, M>>);
  @override
  _i4.Future<_i2.Either<_i5.Rejection, List<M>>> getList<M extends _i6.Model>(
          String? suffix) =>
      (super.noSuchMethod(Invocation.method(#getList, [suffix]),
              returnValue: Future.value(_FakeEither<_i5.Rejection, List<M>>()))
          as _i4.Future<_i2.Either<_i5.Rejection, List<M>>>);
  @override
  _i4.Future<_i2.Option<_i5.Rejection>> post<M extends _i6.Model>(
          String? suffix, M? model) =>
      (super.noSuchMethod(Invocation.method(#post, [suffix, model]),
              returnValue: Future.value(_FakeOption<_i5.Rejection>()))
          as _i4.Future<_i2.Option<_i5.Rejection>>);
  @override
  _i4.Future<_i2.Option<_i5.Rejection>> patch(String? suffix) =>
      (super.noSuchMethod(Invocation.method(#patch, [suffix]),
              returnValue: Future.value(_FakeOption<_i5.Rejection>()))
          as _i4.Future<_i2.Option<_i5.Rejection>>);
  @override
  _i4.Future<_i2.Option<_i5.Rejection>> delete(String? suffix) =>
      (super.noSuchMethod(Invocation.method(#delete, [suffix]),
              returnValue: Future.value(_FakeOption<_i5.Rejection>()))
          as _i4.Future<_i2.Option<_i5.Rejection>>);
  @override
  _i4.Future<_i2.Option<_i5.Rejection>> patchWithBody<M extends _i6.Model>(
          String? suffix, M? model) =>
      (super.noSuchMethod(Invocation.method(#patchWithBody, [suffix, model]),
              returnValue: Future.value(_FakeOption<_i5.Rejection>()))
          as _i4.Future<_i2.Option<_i5.Rejection>>);
  @override
  _i4.Future<_i2.Either<_i5.Rejection, R>>
      postAndGetResponse<R extends _i6.Model, M extends _i6.Model>(
              String? suffix, M? model) =>
          (super.noSuchMethod(
                  Invocation.method(#postAndGetResponse, [suffix, model]),
                  returnValue: Future.value(_FakeEither<_i5.Rejection, R>()))
              as _i4.Future<_i2.Either<_i5.Rejection, R>>);
}

/// A class which mocks [NotificationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockNotificationService extends _i1.Mock
    implements _i7.NotificationService {
  MockNotificationService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Rejection, String>> getFcmToken() =>
      (super.noSuchMethod(Invocation.method(#getFcmToken, []),
              returnValue: Future.value(_FakeEither<_i5.Rejection, String>()))
          as _i4.Future<_i2.Either<_i5.Rejection, String>>);
}
