// Mocks generated by Mockito 5.0.5 from annotations
// in askimam/test/home/ui/home_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:askimam/auth/bloc/auth_bloc.dart' as _i7;
import 'package:askimam/home/chats/bloc/my_chats_bloc.dart' as _i4;
import 'package:askimam/home/chats/bloc/public_chats_bloc.dart' as _i2;
import 'package:askimam/home/chats/bloc/unanswered_chats_bloc.dart' as _i5;
import 'package:askimam/home/favorites/bloc/favorite_bloc.dart' as _i6;
import 'package:bloc/src/bloc.dart' as _i9;
import 'package:bloc/src/transition.dart' as _i8;
import 'package:flutter/src/widgets/navigator.dart' as _i11;
import 'package:flutter_modular/src/core/interfaces/modular_navigator_interface.dart'
    as _i10;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

class _FakePublicChatsState extends _i1.Fake implements _i2.PublicChatsState {}

class _FakeStreamSubscription<T> extends _i1.Fake
    implements _i3.StreamSubscription<T> {}

class _FakeMyChatsState extends _i1.Fake implements _i4.MyChatsState {}

class _FakeUnansweredChatsState extends _i1.Fake
    implements _i5.UnansweredChatsState {}

class _FakeFavoriteState extends _i1.Fake implements _i6.FavoriteState {}

class _FakeAuthState extends _i1.Fake implements _i7.AuthState {}

/// A class which mocks [PublicChatsBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockPublicChatsBloc extends _i1.Mock implements _i2.PublicChatsBloc {
  MockPublicChatsBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.PublicChatsState get state =>
      (super.noSuchMethod(Invocation.getter(#state),
          returnValue: _FakePublicChatsState()) as _i2.PublicChatsState);
  @override
  _i3.Stream<_i2.PublicChatsState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i2.PublicChatsState>.empty())
          as _i3.Stream<_i2.PublicChatsState>);
  @override
  _i3.Stream<_i2.PublicChatsState> mapEventToState(
          _i2.PublicChatsEvent? event) =>
      (super.noSuchMethod(Invocation.method(#mapEventToState, [event]),
              returnValue: Stream<_i2.PublicChatsState>.empty())
          as _i3.Stream<_i2.PublicChatsState>);
  @override
  _i3.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(null),
      returnValueForMissingStub: Future.value()) as _i3.Future<void>);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void add(_i2.PublicChatsEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i2.PublicChatsEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  _i3.Stream<
      _i8.Transition<_i2.PublicChatsEvent, _i2.PublicChatsState>> transformEvents(
          _i3.Stream<_i2.PublicChatsEvent>? events,
          _i9.TransitionFunction<_i2.PublicChatsEvent, _i2.PublicChatsState>?
              transitionFn) =>
      (super.noSuchMethod(
              Invocation.method(#transformEvents, [events, transitionFn]),
              returnValue:
                  Stream<_i8.Transition<_i2.PublicChatsEvent, _i2.PublicChatsState>>.empty())
          as _i3.Stream<
              _i8.Transition<_i2.PublicChatsEvent, _i2.PublicChatsState>>);
  @override
  void emit(_i2.PublicChatsState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onTransition(
          _i8.Transition<_i2.PublicChatsEvent, _i2.PublicChatsState>?
              transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i3.Stream<
      _i8.Transition<_i2.PublicChatsEvent, _i2.PublicChatsState>> transformTransitions(
          _i3.Stream<_i8.Transition<_i2.PublicChatsEvent, _i2.PublicChatsState>>?
              transitions) =>
      (super.noSuchMethod(
              Invocation.method(#transformTransitions, [transitions]),
              returnValue:
                  Stream<_i8.Transition<_i2.PublicChatsEvent, _i2.PublicChatsState>>.empty())
          as _i3.Stream<
              _i8.Transition<_i2.PublicChatsEvent, _i2.PublicChatsState>>);
  @override
  _i3.StreamSubscription<_i2.PublicChatsState> listen(
          void Function(_i2.PublicChatsState)? onData,
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
              returnValue: _FakeStreamSubscription<_i2.PublicChatsState>())
          as _i3.StreamSubscription<_i2.PublicChatsState>);
  @override
  void onChange(_i8.Change<_i2.PublicChatsState>? change) =>
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
  _i3.Stream<_i8.Transition<_i4.MyChatsEvent, _i4.MyChatsState>> transformEvents(
          _i3.Stream<_i4.MyChatsEvent>? events,
          _i9.TransitionFunction<_i4.MyChatsEvent, _i4.MyChatsState>?
              transitionFn) =>
      (super.noSuchMethod(
              Invocation.method(#transformEvents, [events, transitionFn]),
              returnValue: Stream<
                  _i8.Transition<_i4.MyChatsEvent, _i4.MyChatsState>>.empty())
          as _i3.Stream<_i8.Transition<_i4.MyChatsEvent, _i4.MyChatsState>>);
  @override
  void emit(_i4.MyChatsState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onTransition(
          _i8.Transition<_i4.MyChatsEvent, _i4.MyChatsState>? transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i3.Stream<_i8.Transition<_i4.MyChatsEvent, _i4.MyChatsState>>
      transformTransitions(
              _i3.Stream<_i8.Transition<_i4.MyChatsEvent, _i4.MyChatsState>>?
                  transitions) =>
          (super.noSuchMethod(
                  Invocation.method(#transformTransitions, [transitions]),
                  returnValue: Stream<
                      _i8.Transition<_i4.MyChatsEvent, _i4.MyChatsState>>.empty())
              as _i3
                  .Stream<_i8.Transition<_i4.MyChatsEvent, _i4.MyChatsState>>);
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
  void onChange(_i8.Change<_i4.MyChatsState>? change) =>
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

/// A class which mocks [UnansweredChatsBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockUnansweredChatsBloc extends _i1.Mock
    implements _i5.UnansweredChatsBloc {
  MockUnansweredChatsBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.UnansweredChatsState get state => (super.noSuchMethod(
      Invocation.getter(#state),
      returnValue: _FakeUnansweredChatsState()) as _i5.UnansweredChatsState);
  @override
  _i3.Stream<_i5.UnansweredChatsState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i5.UnansweredChatsState>.empty())
          as _i3.Stream<_i5.UnansweredChatsState>);
  @override
  _i3.Stream<_i5.UnansweredChatsState> mapEventToState(
          _i5.UnansweredChatsEvent? event) =>
      (super.noSuchMethod(Invocation.method(#mapEventToState, [event]),
              returnValue: Stream<_i5.UnansweredChatsState>.empty())
          as _i3.Stream<_i5.UnansweredChatsState>);
  @override
  void add(_i5.UnansweredChatsEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i5.UnansweredChatsEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  _i3.Stream<_i8.Transition<_i5.UnansweredChatsEvent, _i5.UnansweredChatsState>>
      transformEvents(
              _i3.Stream<_i5.UnansweredChatsEvent>? events,
              _i9.TransitionFunction<_i5.UnansweredChatsEvent,
                      _i5.UnansweredChatsState>?
                  transitionFn) =>
          (super.noSuchMethod(
              Invocation.method(#transformEvents, [events, transitionFn]),
              returnValue:
                  Stream<_i8.Transition<_i5.UnansweredChatsEvent, _i5.UnansweredChatsState>>.empty()) as _i3
              .Stream<_i8.Transition<_i5.UnansweredChatsEvent, _i5.UnansweredChatsState>>);
  @override
  void emit(_i5.UnansweredChatsState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onTransition(
          _i8.Transition<_i5.UnansweredChatsEvent, _i5.UnansweredChatsState>?
              transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i3.Stream<_i8.Transition<_i5.UnansweredChatsEvent, _i5.UnansweredChatsState>>
      transformTransitions(
              _i3.Stream<_i8.Transition<_i5.UnansweredChatsEvent, _i5.UnansweredChatsState>>?
                  transitions) =>
          (super.noSuchMethod(
                  Invocation.method(#transformTransitions, [transitions]),
                  returnValue:
                      Stream<_i8.Transition<_i5.UnansweredChatsEvent, _i5.UnansweredChatsState>>.empty())
              as _i3.Stream<
                  _i8.Transition<_i5.UnansweredChatsEvent, _i5.UnansweredChatsState>>);
  @override
  _i3.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(null),
      returnValueForMissingStub: Future.value()) as _i3.Future<void>);
  @override
  _i3.StreamSubscription<_i5.UnansweredChatsState> listen(
          void Function(_i5.UnansweredChatsState)? onData,
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
              returnValue: _FakeStreamSubscription<_i5.UnansweredChatsState>())
          as _i3.StreamSubscription<_i5.UnansweredChatsState>);
  @override
  void onChange(_i8.Change<_i5.UnansweredChatsState>? change) =>
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

/// A class which mocks [FavoriteBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockFavoriteBloc extends _i1.Mock implements _i6.FavoriteBloc {
  MockFavoriteBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.FavoriteState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _FakeFavoriteState()) as _i6.FavoriteState);
  @override
  _i3.Stream<_i6.FavoriteState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i6.FavoriteState>.empty())
          as _i3.Stream<_i6.FavoriteState>);
  @override
  _i3.Stream<_i6.FavoriteState> mapEventToState(_i6.FavoriteEvent? event) =>
      (super.noSuchMethod(Invocation.method(#mapEventToState, [event]),
              returnValue: Stream<_i6.FavoriteState>.empty())
          as _i3.Stream<_i6.FavoriteState>);
  @override
  void add(_i6.FavoriteEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i6.FavoriteEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  _i3.Stream<_i8.Transition<_i6.FavoriteEvent, _i6.FavoriteState>> transformEvents(
          _i3.Stream<_i6.FavoriteEvent>? events,
          _i9.TransitionFunction<_i6.FavoriteEvent, _i6.FavoriteState>?
              transitionFn) =>
      (super.noSuchMethod(
              Invocation.method(#transformEvents, [events, transitionFn]),
              returnValue: Stream<
                  _i8.Transition<_i6.FavoriteEvent, _i6.FavoriteState>>.empty())
          as _i3.Stream<_i8.Transition<_i6.FavoriteEvent, _i6.FavoriteState>>);
  @override
  void emit(_i6.FavoriteState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onTransition(
          _i8.Transition<_i6.FavoriteEvent, _i6.FavoriteState>? transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i3.Stream<_i8.Transition<_i6.FavoriteEvent, _i6.FavoriteState>>
      transformTransitions(
              _i3.Stream<_i8.Transition<_i6.FavoriteEvent, _i6.FavoriteState>>?
                  transitions) =>
          (super.noSuchMethod(
                  Invocation.method(#transformTransitions, [transitions]),
                  returnValue: Stream<
                      _i8.Transition<_i6.FavoriteEvent, _i6.FavoriteState>>.empty())
              as _i3
                  .Stream<_i8.Transition<_i6.FavoriteEvent, _i6.FavoriteState>>);
  @override
  _i3.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(null),
      returnValueForMissingStub: Future.value()) as _i3.Future<void>);
  @override
  _i3.StreamSubscription<_i6.FavoriteState> listen(
          void Function(_i6.FavoriteState)? onData,
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
              returnValue: _FakeStreamSubscription<_i6.FavoriteState>())
          as _i3.StreamSubscription<_i6.FavoriteState>);
  @override
  void onChange(_i8.Change<_i6.FavoriteState>? change) =>
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

/// A class which mocks [AuthBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthBloc extends _i1.Mock implements _i7.AuthBloc {
  MockAuthBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.AuthState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _FakeAuthState()) as _i7.AuthState);
  @override
  _i3.Stream<_i7.AuthState> get stream => (super.noSuchMethod(
      Invocation.getter(#stream),
      returnValue: Stream<_i7.AuthState>.empty()) as _i3.Stream<_i7.AuthState>);
  @override
  _i3.Stream<_i7.AuthState> mapEventToState(_i7.AuthEvent? event) =>
      (super.noSuchMethod(Invocation.method(#mapEventToState, [event]),
              returnValue: Stream<_i7.AuthState>.empty())
          as _i3.Stream<_i7.AuthState>);
  @override
  void add(_i7.AuthEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i7.AuthEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  _i3.Stream<_i8.Transition<_i7.AuthEvent, _i7.AuthState>> transformEvents(
          _i3.Stream<_i7.AuthEvent>? events,
          _i9.TransitionFunction<_i7.AuthEvent, _i7.AuthState>? transitionFn) =>
      (super.noSuchMethod(
              Invocation.method(#transformEvents, [events, transitionFn]),
              returnValue:
                  Stream<_i8.Transition<_i7.AuthEvent, _i7.AuthState>>.empty())
          as _i3.Stream<_i8.Transition<_i7.AuthEvent, _i7.AuthState>>);
  @override
  void emit(_i7.AuthState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onTransition(_i8.Transition<_i7.AuthEvent, _i7.AuthState>? transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i3.Stream<_i8.Transition<_i7.AuthEvent, _i7.AuthState>> transformTransitions(
          _i3.Stream<_i8.Transition<_i7.AuthEvent, _i7.AuthState>>?
              transitions) =>
      (super.noSuchMethod(
              Invocation.method(#transformTransitions, [transitions]),
              returnValue:
                  Stream<_i8.Transition<_i7.AuthEvent, _i7.AuthState>>.empty())
          as _i3.Stream<_i8.Transition<_i7.AuthEvent, _i7.AuthState>>);
  @override
  _i3.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(null),
      returnValueForMissingStub: Future.value()) as _i3.Future<void>);
  @override
  _i3.StreamSubscription<_i7.AuthState> listen(
          void Function(_i7.AuthState)? onData,
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
              returnValue: _FakeStreamSubscription<_i7.AuthState>())
          as _i3.StreamSubscription<_i7.AuthState>);
  @override
  void onChange(_i8.Change<_i7.AuthState>? change) =>
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

/// A class which mocks [IModularNavigator].
///
/// See the documentation for Mockito's code generation for more information.
class MockIModularNavigator extends _i1.Mock implements _i10.IModularNavigator {
  MockIModularNavigator() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get path =>
      (super.noSuchMethod(Invocation.getter(#path), returnValue: '') as String);
  @override
  String get localPath =>
      (super.noSuchMethod(Invocation.getter(#localPath), returnValue: '')
          as String);
  @override
  String get modulePath =>
      (super.noSuchMethod(Invocation.getter(#modulePath), returnValue: '')
          as String);
  @override
  void addListener(void Function()? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(void Function()? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  _i3.Future<T?> push<T extends Object?>(_i11.Route<T>? route) =>
      (super.noSuchMethod(Invocation.method(#push, [route]),
          returnValue: Future<T?>.value(null)) as _i3.Future<T?>);
  @override
  _i3.Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(
          String? routeName,
          {TO? result,
          Object? arguments,
          bool? forRoot = false}) =>
      (super.noSuchMethod(
          Invocation.method(#popAndPushNamed, [routeName],
              {#result: result, #arguments: arguments, #forRoot: forRoot}),
          returnValue: Future<T?>.value(null)) as _i3.Future<T?>);
  @override
  _i3.Future<T?> pushNamed<T extends Object?>(String? routeName,
          {Object? arguments, bool? forRoot = false}) =>
      (super.noSuchMethod(
          Invocation.method(#pushNamed, [routeName],
              {#arguments: arguments, #forRoot: forRoot}),
          returnValue: Future<T?>.value(null)) as _i3.Future<T?>);
  @override
  _i3.Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
          String? newRouteName, bool Function(_i11.Route<dynamic>)? predicate,
          {Object? arguments, bool? forRoot = false}) =>
      (super.noSuchMethod(
          Invocation.method(#pushNamedAndRemoveUntil, [newRouteName, predicate],
              {#arguments: arguments, #forRoot: forRoot}),
          returnValue: Future<T?>.value(null)) as _i3.Future<T?>);
  @override
  _i3.Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
          String? routeName,
          {TO? result,
          Object? arguments,
          bool? forRoot = false}) =>
      (super.noSuchMethod(
          Invocation.method(#pushReplacementNamed, [routeName],
              {#result: result, #arguments: arguments, #forRoot: forRoot}),
          returnValue: Future<T?>.value(null)) as _i3.Future<T?>);
  @override
  void pop<T extends Object>([T? result]) =>
      super.noSuchMethod(Invocation.method(#pop, [result]),
          returnValueForMissingStub: null);
  @override
  bool canPop() =>
      (super.noSuchMethod(Invocation.method(#canPop, []), returnValue: false)
          as bool);
  @override
  _i3.Future<bool> maybePop<T extends Object>([T? result]) =>
      (super.noSuchMethod(Invocation.method(#maybePop, [result]),
          returnValue: Future<bool>.value(false)) as _i3.Future<bool>);
  @override
  void popUntil(bool Function(_i11.Route<dynamic>)? predicate) =>
      super.noSuchMethod(Invocation.method(#popUntil, [predicate]),
          returnValueForMissingStub: null);
  @override
  void navigate(String? path, {dynamic arguments, bool? replaceAll = false}) =>
      super.noSuchMethod(
          Invocation.method(#navigate, [path],
              {#arguments: arguments, #replaceAll: replaceAll}),
          returnValueForMissingStub: null);
}
