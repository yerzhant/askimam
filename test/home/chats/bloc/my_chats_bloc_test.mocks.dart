// Mocks generated by Mockito 5.0.3 from annotations
// in askimam/test/home/chats/bloc/my_chats_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:askimam/chat/domain/model/chat.dart' as _i6;
import 'package:askimam/chat/domain/repo/chat_repository.dart' as _i3;
import 'package:askimam/common/domain/model/rejection.dart' as _i5;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

class _FakeEither<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeOption<A> extends _i1.Fake implements _i2.Option<A> {}

/// A class which mocks [ChatRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockChatRepository extends _i1.Mock implements _i3.ChatRepository {
  MockChatRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Rejection, _i6.Chat>> get(int? id) =>
      (super.noSuchMethod(Invocation.method(#get, [id]),
              returnValue: Future.value(_FakeEither<_i5.Rejection, _i6.Chat>()))
          as _i4.Future<_i2.Either<_i5.Rejection, _i6.Chat>>);
  @override
  _i4.Future<_i2.Either<_i5.Rejection, List<_i6.Chat>>> getMy(
          int? offset, int? pageSize) =>
      (super.noSuchMethod(Invocation.method(#getMy, [offset, pageSize]),
              returnValue:
                  Future.value(_FakeEither<_i5.Rejection, List<_i6.Chat>>()))
          as _i4.Future<_i2.Either<_i5.Rejection, List<_i6.Chat>>>);
  @override
  _i4.Future<_i2.Either<_i5.Rejection, List<_i6.Chat>>> getPublic(
          int? offset, int? pageSize) =>
      (super.noSuchMethod(Invocation.method(#getPublic, [offset, pageSize]),
              returnValue:
                  Future.value(_FakeEither<_i5.Rejection, List<_i6.Chat>>()))
          as _i4.Future<_i2.Either<_i5.Rejection, List<_i6.Chat>>>);
  @override
  _i4.Future<_i2.Either<_i5.Rejection, List<_i6.Chat>>> getUnanswered(
          int? offset, int? pageSize) =>
      (super.noSuchMethod(Invocation.method(#getUnanswered, [offset, pageSize]),
              returnValue:
                  Future.value(_FakeEither<_i5.Rejection, List<_i6.Chat>>()))
          as _i4.Future<_i2.Either<_i5.Rejection, List<_i6.Chat>>>);
  @override
  _i4.Future<_i2.Option<_i5.Rejection>> add(
          _i6.ChatType? type, String? subject, String? text) =>
      (super.noSuchMethod(Invocation.method(#add, [type, subject, text]),
              returnValue: Future.value(_FakeOption<_i5.Rejection>()))
          as _i4.Future<_i2.Option<_i5.Rejection>>);
  @override
  _i4.Future<_i2.Option<_i5.Rejection>> updateSubject(
          int? id, String? subject) =>
      (super.noSuchMethod(Invocation.method(#updateSubject, [id, subject]),
              returnValue: Future.value(_FakeOption<_i5.Rejection>()))
          as _i4.Future<_i2.Option<_i5.Rejection>>);
  @override
  _i4.Future<_i2.Option<_i5.Rejection>> delete(_i6.Chat? chat) =>
      (super.noSuchMethod(Invocation.method(#delete, [chat]),
              returnValue: Future.value(_FakeOption<_i5.Rejection>()))
          as _i4.Future<_i2.Option<_i5.Rejection>>);
  @override
  _i4.Future<_i2.Option<_i5.Rejection>> setViewedFlag(int? id) =>
      (super.noSuchMethod(Invocation.method(#setViewedFlag, [id]),
              returnValue: Future.value(_FakeOption<_i5.Rejection>()))
          as _i4.Future<_i2.Option<_i5.Rejection>>);
  @override
  _i4.Future<_i2.Option<_i5.Rejection>> returnToUnanswered(int? id) =>
      (super.noSuchMethod(Invocation.method(#returnToUnanswered, [id]),
              returnValue: Future.value(_FakeOption<_i5.Rejection>()))
          as _i4.Future<_i2.Option<_i5.Rejection>>);
}
