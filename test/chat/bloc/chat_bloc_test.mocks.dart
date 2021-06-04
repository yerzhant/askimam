// Mocks generated by Mockito 5.0.7 from annotations
// in askimam/test/chat/bloc/chat_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;
import 'dart:io' as _i13;

import 'package:askimam/auth/bloc/auth_bloc.dart' as _i2;
import 'package:askimam/chat/domain/model/chat.dart' as _i11;
import 'package:askimam/chat/domain/repo/chat_repository.dart' as _i9;
import 'package:askimam/chat/domain/repo/message_repository.dart' as _i12;
import 'package:askimam/common/domain/model/rejection.dart' as _i10;
import 'package:askimam/home/chats/bloc/my_chats_bloc.dart' as _i4;
import 'package:askimam/home/chats/bloc/unanswered_chats_bloc.dart' as _i6;
import 'package:bloc/src/bloc.dart' as _i8;
import 'package:bloc/src/transition.dart' as _i7;
import 'package:dartz/dartz.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

// ignore_for_file: prefer_const_constructors

// ignore_for_file: avoid_redundant_argument_values

class _FakeAuthState extends _i1.Fake implements _i2.AuthState {}

class _FakeStreamSubscription<T> extends _i1.Fake
    implements _i3.StreamSubscription<T> {}

class _FakeMyChatsState extends _i1.Fake implements _i4.MyChatsState {}

class _FakeEither<L, R> extends _i1.Fake implements _i5.Either<L, R> {}

class _FakeOption<A> extends _i1.Fake implements _i5.Option<A> {}

class _FakeUnansweredChatsState extends _i1.Fake
    implements _i6.UnansweredChatsState {}

/// A class which mocks [AuthBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthBloc extends _i1.Mock implements _i2.AuthBloc {
  MockAuthBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.AuthState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _FakeAuthState()) as _i2.AuthState);
  @override
  _i3.Stream<_i2.AuthState> get stream => (super.noSuchMethod(
      Invocation.getter(#stream),
      returnValue: Stream<_i2.AuthState>.empty()) as _i3.Stream<_i2.AuthState>);
  @override
  _i3.Stream<_i2.AuthState> mapEventToState(_i2.AuthEvent? event) =>
      (super.noSuchMethod(Invocation.method(#mapEventToState, [event]),
              returnValue: Stream<_i2.AuthState>.empty())
          as _i3.Stream<_i2.AuthState>);
  @override
  void add(_i2.AuthEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i2.AuthEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  _i3.Stream<_i7.Transition<_i2.AuthEvent, _i2.AuthState>> transformEvents(
          _i3.Stream<_i2.AuthEvent>? events,
          _i8.TransitionFunction<_i2.AuthEvent, _i2.AuthState>? transitionFn) =>
      (super.noSuchMethod(
              Invocation.method(#transformEvents, [events, transitionFn]),
              returnValue:
                  Stream<_i7.Transition<_i2.AuthEvent, _i2.AuthState>>.empty())
          as _i3.Stream<_i7.Transition<_i2.AuthEvent, _i2.AuthState>>);
  @override
  void emit(_i2.AuthState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onTransition(_i7.Transition<_i2.AuthEvent, _i2.AuthState>? transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i3.Stream<_i7.Transition<_i2.AuthEvent, _i2.AuthState>> transformTransitions(
          _i3.Stream<_i7.Transition<_i2.AuthEvent, _i2.AuthState>>?
              transitions) =>
      (super.noSuchMethod(
              Invocation.method(#transformTransitions, [transitions]),
              returnValue:
                  Stream<_i7.Transition<_i2.AuthEvent, _i2.AuthState>>.empty())
          as _i3.Stream<_i7.Transition<_i2.AuthEvent, _i2.AuthState>>);
  @override
  _i3.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(null),
      returnValueForMissingStub: Future.value()) as _i3.Future<void>);
  @override
  _i3.StreamSubscription<_i2.AuthState> listen(
          void Function(_i2.AuthState)? onData,
          {Function? onError,
          void Function()? onDone,
          bool? cancelOnError}) =>
      (super.noSuchMethod(
              Invocation.method(#listen, [
                onData
              ], {
                #onError: onError,
                #onDone: onDone,
                #cancelOnError: cancelOnError
              }),
              returnValue: _FakeStreamSubscription<_i2.AuthState>())
          as _i3.StreamSubscription<_i2.AuthState>);
  @override
  void onChange(_i7.Change<_i2.AuthState>? change) =>
      super.noSuchMethod(Invocation.method(#onChange, [change]),
          returnValueForMissingStub: null);
  @override
  void addError(Object? error, [StackTrace? stackTrace]) =>
      super.noSuchMethod(Invocation.method(#addError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  void onError(Object? error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#onError, [error, stackTrace]),
          returnValueForMissingStub: null);
}

/// A class which mocks [MyChatsBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockMyChatsBloc extends _i1.Mock implements _i4.MyChatsBloc {
  MockMyChatsBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.MyChatsState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _FakeMyChatsState()) as _i4.MyChatsState);
  @override
  _i3.Stream<_i4.MyChatsState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i4.MyChatsState>.empty())
          as _i3.Stream<_i4.MyChatsState>);
  @override
  _i3.Stream<_i4.MyChatsState> mapEventToState(_i4.MyChatsEvent? event) =>
      (super.noSuchMethod(Invocation.method(#mapEventToState, [event]),
              returnValue: Stream<_i4.MyChatsState>.empty())
          as _i3.Stream<_i4.MyChatsState>);
  @override
  _i3.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(null),
      returnValueForMissingStub: Future.value()) as _i3.Future<void>);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void add(_i4.MyChatsEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i4.MyChatsEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  _i3.Stream<_i7.Transition<_i4.MyChatsEvent, _i4.MyChatsState>> transformEvents(
          _i3.Stream<_i4.MyChatsEvent>? events,
          _i8.TransitionFunction<_i4.MyChatsEvent, _i4.MyChatsState>?
              transitionFn) =>
      (super.noSuchMethod(
              Invocation.method(#transformEvents, [events, transitionFn]),
              returnValue: Stream<
                  _i7.Transition<_i4.MyChatsEvent, _i4.MyChatsState>>.empty())
          as _i3.Stream<_i7.Transition<_i4.MyChatsEvent, _i4.MyChatsState>>);
  @override
  void emit(_i4.MyChatsState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onTransition(
          _i7.Transition<_i4.MyChatsEvent, _i4.MyChatsState>? transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i3.Stream<_i7.Transition<_i4.MyChatsEvent, _i4.MyChatsState>>
      transformTransitions(
              _i3.Stream<_i7.Transition<_i4.MyChatsEvent, _i4.MyChatsState>>?
                  transitions) =>
          (super.noSuchMethod(
                  Invocation.method(#transformTransitions, [transitions]),
                  returnValue: Stream<
                      _i7.Transition<_i4.MyChatsEvent, _i4.MyChatsState>>.empty())
              as _i3
                  .Stream<_i7.Transition<_i4.MyChatsEvent, _i4.MyChatsState>>);
  @override
  _i3.StreamSubscription<_i4.MyChatsState> listen(
          void Function(_i4.MyChatsState)? onData,
          {Function? onError,
          void Function()? onDone,
          bool? cancelOnError}) =>
      (super.noSuchMethod(
              Invocation.method(#listen, [
                onData
              ], {
                #onError: onError,
                #onDone: onDone,
                #cancelOnError: cancelOnError
              }),
              returnValue: _FakeStreamSubscription<_i4.MyChatsState>())
          as _i3.StreamSubscription<_i4.MyChatsState>);
  @override
  void onChange(_i7.Change<_i4.MyChatsState>? change) =>
      super.noSuchMethod(Invocation.method(#onChange, [change]),
          returnValueForMissingStub: null);
  @override
  void addError(Object? error, [StackTrace? stackTrace]) =>
      super.noSuchMethod(Invocation.method(#addError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  void onError(Object? error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#onError, [error, stackTrace]),
          returnValueForMissingStub: null);
}

/// A class which mocks [ChatRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockChatRepository extends _i1.Mock implements _i9.ChatRepository {
  MockChatRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i5.Either<_i10.Rejection, _i11.Chat>> get(int? id) =>
      (super.noSuchMethod(Invocation.method(#get, [id]),
              returnValue: Future<_i5.Either<_i10.Rejection, _i11.Chat>>.value(
                  _FakeEither<_i10.Rejection, _i11.Chat>()))
          as _i3.Future<_i5.Either<_i10.Rejection, _i11.Chat>>);
  @override
  _i3.Future<_i5.Either<_i10.Rejection, List<_i11.Chat>>> find(
          String? phrase) =>
      (super.noSuchMethod(Invocation.method(#find, [phrase]),
              returnValue:
                  Future<_i5.Either<_i10.Rejection, List<_i11.Chat>>>.value(
                      _FakeEither<_i10.Rejection, List<_i11.Chat>>()))
          as _i3.Future<_i5.Either<_i10.Rejection, List<_i11.Chat>>>);
  @override
  _i3.Future<_i5.Either<_i10.Rejection, List<_i11.Chat>>> getMy(
          int? offset, int? pageSize) =>
      (super.noSuchMethod(Invocation.method(#getMy, [offset, pageSize]),
              returnValue:
                  Future<_i5.Either<_i10.Rejection, List<_i11.Chat>>>.value(
                      _FakeEither<_i10.Rejection, List<_i11.Chat>>()))
          as _i3.Future<_i5.Either<_i10.Rejection, List<_i11.Chat>>>);
  @override
  _i3.Future<_i5.Either<_i10.Rejection, List<_i11.Chat>>> getPublic(
          int? offset, int? pageSize) =>
      (super.noSuchMethod(Invocation.method(#getPublic, [offset, pageSize]),
              returnValue:
                  Future<_i5.Either<_i10.Rejection, List<_i11.Chat>>>.value(
                      _FakeEither<_i10.Rejection, List<_i11.Chat>>()))
          as _i3.Future<_i5.Either<_i10.Rejection, List<_i11.Chat>>>);
  @override
  _i3.Future<_i5.Either<_i10.Rejection, List<_i11.Chat>>> getUnanswered(
          int? offset, int? pageSize) =>
      (super.noSuchMethod(Invocation.method(#getUnanswered, [offset, pageSize]),
              returnValue:
                  Future<_i5.Either<_i10.Rejection, List<_i11.Chat>>>.value(
                      _FakeEither<_i10.Rejection, List<_i11.Chat>>()))
          as _i3.Future<_i5.Either<_i10.Rejection, List<_i11.Chat>>>);
  @override
  _i3.Future<_i5.Option<_i10.Rejection>> add(
          _i11.ChatType? type, String? subject, String? text) =>
      (super.noSuchMethod(Invocation.method(#add, [type, subject, text]),
              returnValue: Future<_i5.Option<_i10.Rejection>>.value(
                  _FakeOption<_i10.Rejection>()))
          as _i3.Future<_i5.Option<_i10.Rejection>>);
  @override
  _i3.Future<_i5.Option<_i10.Rejection>> updateSubject(
          int? id, String? subject) =>
      (super.noSuchMethod(Invocation.method(#updateSubject, [id, subject]),
              returnValue: Future<_i5.Option<_i10.Rejection>>.value(
                  _FakeOption<_i10.Rejection>()))
          as _i3.Future<_i5.Option<_i10.Rejection>>);
  @override
  _i3.Future<_i5.Option<_i10.Rejection>> delete(_i11.Chat? chat) =>
      (super.noSuchMethod(Invocation.method(#delete, [chat]),
              returnValue: Future<_i5.Option<_i10.Rejection>>.value(
                  _FakeOption<_i10.Rejection>()))
          as _i3.Future<_i5.Option<_i10.Rejection>>);
  @override
  _i3.Future<_i5.Option<_i10.Rejection>> setViewedFlag(int? id) =>
      (super.noSuchMethod(Invocation.method(#setViewedFlag, [id]),
              returnValue: Future<_i5.Option<_i10.Rejection>>.value(
                  _FakeOption<_i10.Rejection>()))
          as _i3.Future<_i5.Option<_i10.Rejection>>);
  @override
  _i3.Future<_i5.Option<_i10.Rejection>> returnToUnanswered(int? id) =>
      (super.noSuchMethod(Invocation.method(#returnToUnanswered, [id]),
              returnValue: Future<_i5.Option<_i10.Rejection>>.value(
                  _FakeOption<_i10.Rejection>()))
          as _i3.Future<_i5.Option<_i10.Rejection>>);
}

/// A class which mocks [MessageRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMessageRepository extends _i1.Mock implements _i12.MessageRepository {
  MockMessageRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i5.Option<_i10.Rejection>> addText(int? chatId, String? text) =>
      (super.noSuchMethod(Invocation.method(#addText, [chatId, text]),
              returnValue: Future<_i5.Option<_i10.Rejection>>.value(
                  _FakeOption<_i10.Rejection>()))
          as _i3.Future<_i5.Option<_i10.Rejection>>);
  @override
  _i3.Future<_i5.Option<_i10.Rejection>> addAudio(
          int? chatId, _i13.File? audio, String? duration) =>
      (super.noSuchMethod(
              Invocation.method(#addAudio, [chatId, audio, duration]),
              returnValue: Future<_i5.Option<_i10.Rejection>>.value(
                  _FakeOption<_i10.Rejection>()))
          as _i3.Future<_i5.Option<_i10.Rejection>>);
  @override
  _i3.Future<_i5.Option<_i10.Rejection>> delete(int? chatId, int? messageId) =>
      (super.noSuchMethod(Invocation.method(#delete, [chatId, messageId]),
              returnValue: Future<_i5.Option<_i10.Rejection>>.value(
                  _FakeOption<_i10.Rejection>()))
          as _i3.Future<_i5.Option<_i10.Rejection>>);
  @override
  _i3.Future<_i5.Option<_i10.Rejection>> updateText(
          int? chatId, int? messageId, String? text) =>
      (super.noSuchMethod(
              Invocation.method(#updateText, [chatId, messageId, text]),
              returnValue: Future<_i5.Option<_i10.Rejection>>.value(
                  _FakeOption<_i10.Rejection>()))
          as _i3.Future<_i5.Option<_i10.Rejection>>);
}

/// A class which mocks [UnansweredChatsBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockUnansweredChatsBloc extends _i1.Mock
    implements _i6.UnansweredChatsBloc {
  MockUnansweredChatsBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.UnansweredChatsState get state => (super.noSuchMethod(
      Invocation.getter(#state),
      returnValue: _FakeUnansweredChatsState()) as _i6.UnansweredChatsState);
  @override
  _i3.Stream<_i6.UnansweredChatsState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i6.UnansweredChatsState>.empty())
          as _i3.Stream<_i6.UnansweredChatsState>);
  @override
  _i3.Stream<_i6.UnansweredChatsState> mapEventToState(
          _i6.UnansweredChatsEvent? event) =>
      (super.noSuchMethod(Invocation.method(#mapEventToState, [event]),
              returnValue: Stream<_i6.UnansweredChatsState>.empty())
          as _i3.Stream<_i6.UnansweredChatsState>);
  @override
  void add(_i6.UnansweredChatsEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i6.UnansweredChatsEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  _i3.Stream<_i7.Transition<_i6.UnansweredChatsEvent, _i6.UnansweredChatsState>>
      transformEvents(
              _i3.Stream<_i6.UnansweredChatsEvent>? events,
              _i8.TransitionFunction<_i6.UnansweredChatsEvent,
                      _i6.UnansweredChatsState>?
                  transitionFn) =>
          (super.noSuchMethod(
              Invocation.method(#transformEvents, [events, transitionFn]),
              returnValue:
                  Stream<_i7.Transition<_i6.UnansweredChatsEvent, _i6.UnansweredChatsState>>.empty()) as _i3
              .Stream<_i7.Transition<_i6.UnansweredChatsEvent, _i6.UnansweredChatsState>>);
  @override
  void emit(_i6.UnansweredChatsState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onTransition(
          _i7.Transition<_i6.UnansweredChatsEvent, _i6.UnansweredChatsState>?
              transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i3.Stream<_i7.Transition<_i6.UnansweredChatsEvent, _i6.UnansweredChatsState>>
      transformTransitions(
              _i3.Stream<_i7.Transition<_i6.UnansweredChatsEvent, _i6.UnansweredChatsState>>?
                  transitions) =>
          (super.noSuchMethod(
                  Invocation.method(#transformTransitions, [transitions]),
                  returnValue:
                      Stream<_i7.Transition<_i6.UnansweredChatsEvent, _i6.UnansweredChatsState>>.empty())
              as _i3.Stream<
                  _i7.Transition<_i6.UnansweredChatsEvent, _i6.UnansweredChatsState>>);
  @override
  _i3.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(null),
      returnValueForMissingStub: Future.value()) as _i3.Future<void>);
  @override
  _i3.StreamSubscription<_i6.UnansweredChatsState> listen(
          void Function(_i6.UnansweredChatsState)? onData,
          {Function? onError,
          void Function()? onDone,
          bool? cancelOnError}) =>
      (super.noSuchMethod(
              Invocation.method(#listen, [
                onData
              ], {
                #onError: onError,
                #onDone: onDone,
                #cancelOnError: cancelOnError
              }),
              returnValue: _FakeStreamSubscription<_i6.UnansweredChatsState>())
          as _i3.StreamSubscription<_i6.UnansweredChatsState>);
  @override
  void onChange(_i7.Change<_i6.UnansweredChatsState>? change) =>
      super.noSuchMethod(Invocation.method(#onChange, [change]),
          returnValueForMissingStub: null);
  @override
  void addError(Object? error, [StackTrace? stackTrace]) =>
      super.noSuchMethod(Invocation.method(#addError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  void onError(Object? error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#onError, [error, stackTrace]),
          returnValueForMissingStub: null);
}
