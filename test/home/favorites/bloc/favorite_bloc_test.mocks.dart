// Mocks generated by Mockito 5.0.3 from annotations
// in askimam/test/home/favorites/bloc/favorite_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:askimam/chat/domain/model/chat.dart' as _i7;
import 'package:askimam/common/domain/model/rejection.dart' as _i5;
import 'package:askimam/home/favorites/domain/model/favorite.dart' as _i6;
import 'package:askimam/home/favorites/domain/repo/favorite_repository.dart'
    as _i3;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

class _FakeEither<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeOption<A> extends _i1.Fake implements _i2.Option<A> {}

/// A class which mocks [FavoriteRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockFavoriteRepository extends _i1.Mock
    implements _i3.FavoriteRepository {
  MockFavoriteRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Rejection, List<_i6.Favorite>>> get() =>
      (super.noSuchMethod(Invocation.method(#get, []),
              returnValue: Future.value(
                  _FakeEither<_i5.Rejection, List<_i6.Favorite>>()))
          as _i4.Future<_i2.Either<_i5.Rejection, List<_i6.Favorite>>>);
  @override
  _i4.Future<_i2.Option<_i5.Rejection>> add(_i7.Chat? chat) =>
      (super.noSuchMethod(Invocation.method(#add, [chat]),
              returnValue: Future.value(_FakeOption<_i5.Rejection>()))
          as _i4.Future<_i2.Option<_i5.Rejection>>);
  @override
  _i4.Future<_i2.Option<_i5.Rejection>> delete(int? chatId) =>
      (super.noSuchMethod(Invocation.method(#delete, [chatId]),
              returnValue: Future.value(_FakeOption<_i5.Rejection>()))
          as _i4.Future<_i2.Option<_i5.Rejection>>);
}
