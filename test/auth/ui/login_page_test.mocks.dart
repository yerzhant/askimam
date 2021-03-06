// Mocks generated by Mockito 5.0.7 from annotations
// in askimam/test/auth/ui/login_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:askimam/auth/bloc/auth_bloc.dart' as _i2;
import 'package:bloc/src/bloc.dart' as _i5;
import 'package:bloc/src/transition.dart' as _i4;
import 'package:flutter/src/widgets/navigator.dart' as _i7;
import 'package:flutter_modular/src/core/interfaces/modular_navigator_interface.dart'
    as _i6;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

// ignore_for_file: prefer_const_constructors

// ignore_for_file: avoid_redundant_argument_values

class _FakeAuthState extends _i1.Fake implements _i2.AuthState {}

class _FakeStreamSubscription<T> extends _i1.Fake
    implements _i3.StreamSubscription<T> {}

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
  _i3.Stream<_i4.Transition<_i2.AuthEvent, _i2.AuthState>> transformEvents(
          _i3.Stream<_i2.AuthEvent>? events,
          _i5.TransitionFunction<_i2.AuthEvent, _i2.AuthState>? transitionFn) =>
      (super.noSuchMethod(
              Invocation.method(#transformEvents, [events, transitionFn]),
              returnValue:
                  Stream<_i4.Transition<_i2.AuthEvent, _i2.AuthState>>.empty())
          as _i3.Stream<_i4.Transition<_i2.AuthEvent, _i2.AuthState>>);
  @override
  void emit(_i2.AuthState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void onTransition(_i4.Transition<_i2.AuthEvent, _i2.AuthState>? transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i3.Stream<_i4.Transition<_i2.AuthEvent, _i2.AuthState>> transformTransitions(
          _i3.Stream<_i4.Transition<_i2.AuthEvent, _i2.AuthState>>?
              transitions) =>
      (super.noSuchMethod(
              Invocation.method(#transformTransitions, [transitions]),
              returnValue:
                  Stream<_i4.Transition<_i2.AuthEvent, _i2.AuthState>>.empty())
          as _i3.Stream<_i4.Transition<_i2.AuthEvent, _i2.AuthState>>);
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
  void onChange(_i4.Change<_i2.AuthState>? change) =>
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
class MockIModularNavigator extends _i1.Mock implements _i6.IModularNavigator {
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
  _i3.Future<T?> push<T extends Object?>(_i7.Route<T>? route) =>
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
          String? newRouteName, bool Function(_i7.Route<dynamic>)? predicate,
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
  void popUntil(bool Function(_i7.Route<dynamic>)? predicate) =>
      super.noSuchMethod(Invocation.method(#popUntil, [predicate]),
          returnValueForMissingStub: null);
  @override
  void navigate(String? path, {dynamic arguments, bool? replaceAll = false}) =>
      super.noSuchMethod(
          Invocation.method(#navigate, [path],
              {#arguments: arguments, #replaceAll: replaceAll}),
          returnValueForMissingStub: null);
}
