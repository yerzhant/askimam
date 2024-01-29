// Mocks generated by Mockito 5.4.4 from annotations
// in askimam/test/chat/infra/http_message_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:io' as _i7;

import 'package:askimam/chat/domain/model/notification.dart' as _i9;
import 'package:askimam/common/domain/model/model.dart' as _i6;
import 'package:askimam/common/domain/model/rejection.dart' as _i5;
import 'package:askimam/common/domain/service/api_client.dart' as _i3;
import 'package:askimam/common/domain/service/notification_service.dart' as _i8;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeOption_1<A> extends _i1.SmartFake implements _i2.Option<A> {
  _FakeOption_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

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
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [suffix],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Rejection, M>>.value(
            _FakeEither_0<_i5.Rejection, M>(
          this,
          Invocation.method(
            #get,
            [suffix],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Rejection, M>>);

  @override
  _i4.Future<_i2.Either<_i5.Rejection, List<M>>> getList<M extends _i6.Model>(
          String? suffix) =>
      (super.noSuchMethod(
        Invocation.method(
          #getList,
          [suffix],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Rejection, List<M>>>.value(
            _FakeEither_0<_i5.Rejection, List<M>>(
          this,
          Invocation.method(
            #getList,
            [suffix],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Rejection, List<M>>>);

  @override
  _i4.Future<_i2.Option<_i5.Rejection>> post<M extends _i6.Model>(
    String? suffix,
    M? model,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [
            suffix,
            model,
          ],
        ),
        returnValue: _i4.Future<_i2.Option<_i5.Rejection>>.value(
            _FakeOption_1<_i5.Rejection>(
          this,
          Invocation.method(
            #post,
            [
              suffix,
              model,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Option<_i5.Rejection>>);

  @override
  _i4.Future<_i2.Option<_i5.Rejection>> patch(String? suffix) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [suffix],
        ),
        returnValue: _i4.Future<_i2.Option<_i5.Rejection>>.value(
            _FakeOption_1<_i5.Rejection>(
          this,
          Invocation.method(
            #patch,
            [suffix],
          ),
        )),
      ) as _i4.Future<_i2.Option<_i5.Rejection>>);

  @override
  _i4.Future<_i2.Option<_i5.Rejection>> delete(String? suffix) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [suffix],
        ),
        returnValue: _i4.Future<_i2.Option<_i5.Rejection>>.value(
            _FakeOption_1<_i5.Rejection>(
          this,
          Invocation.method(
            #delete,
            [suffix],
          ),
        )),
      ) as _i4.Future<_i2.Option<_i5.Rejection>>);

  @override
  _i4.Future<_i2.Option<_i5.Rejection>> patchWithBody<M extends _i6.Model>(
    String? suffix,
    M? model,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #patchWithBody,
          [
            suffix,
            model,
          ],
        ),
        returnValue: _i4.Future<_i2.Option<_i5.Rejection>>.value(
            _FakeOption_1<_i5.Rejection>(
          this,
          Invocation.method(
            #patchWithBody,
            [
              suffix,
              model,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Option<_i5.Rejection>>);

  @override
  _i4.Future<_i2.Either<_i5.Rejection, R>>
      postAndGetResponse<R extends _i6.Model, M extends _i6.Model>(
    String? suffix,
    M? model,
  ) =>
          (super.noSuchMethod(
            Invocation.method(
              #postAndGetResponse,
              [
                suffix,
                model,
              ],
            ),
            returnValue: _i4.Future<_i2.Either<_i5.Rejection, R>>.value(
                _FakeEither_0<_i5.Rejection, R>(
              this,
              Invocation.method(
                #postAndGetResponse,
                [
                  suffix,
                  model,
                ],
              ),
            )),
          ) as _i4.Future<_i2.Either<_i5.Rejection, R>>);

  @override
  _i4.Future<_i2.Option<_i5.Rejection>> uploadFile(
    String? suffix,
    _i7.File? file,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #uploadFile,
          [
            suffix,
            file,
          ],
        ),
        returnValue: _i4.Future<_i2.Option<_i5.Rejection>>.value(
            _FakeOption_1<_i5.Rejection>(
          this,
          Invocation.method(
            #uploadFile,
            [
              suffix,
              file,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Option<_i5.Rejection>>);

  @override
  void setJwt(String? jwt) => super.noSuchMethod(
        Invocation.method(
          #setJwt,
          [jwt],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void resetJwt() => super.noSuchMethod(
        Invocation.method(
          #resetJwt,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [NotificationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockNotificationService extends _i1.Mock
    implements _i8.NotificationService {
  MockNotificationService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Rejection, String>> getFcmToken() =>
      (super.noSuchMethod(
        Invocation.method(
          #getFcmToken,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Rejection, String>>.value(
            _FakeEither_0<_i5.Rejection, String>(
          this,
          Invocation.method(
            #getFcmToken,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Rejection, String>>);

  @override
  _i4.Stream<String> tokenRefreshes() => (super.noSuchMethod(
        Invocation.method(
          #tokenRefreshes,
          [],
        ),
        returnValue: _i4.Stream<String>.empty(),
      ) as _i4.Stream<String>);

  @override
  _i4.Stream<_i9.Notification> notifications() => (super.noSuchMethod(
        Invocation.method(
          #notifications,
          [],
        ),
        returnValue: _i4.Stream<_i9.Notification>.empty(),
      ) as _i4.Stream<_i9.Notification>);
}
