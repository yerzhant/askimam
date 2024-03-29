// Mocks generated by Mockito 5.4.4 from annotations
// in askimam/test/home/chats/ui/widget/public_chats_widget_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:ui' as _i10;

import 'package:askimam/auth/bloc/auth_bloc.dart' as _i2;
import 'package:askimam/home/chats/bloc/public_chats_bloc.dart' as _i7;
import 'package:askimam/home/favorites/bloc/favorite_bloc.dart' as _i6;
import 'package:bloc/bloc.dart' as _i5;
import 'package:flutter/material.dart' as _i9;
import 'package:flutter_modular/flutter_modular.dart' as _i8;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i3;

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

/// A class which mocks [AuthBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthBloc extends _i1.Mock implements _i2.AuthBloc {
  MockAuthBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.AuthState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _i3.dummyValue<_i2.AuthState>(
          this,
          Invocation.getter(#state),
        ),
      ) as _i2.AuthState);

  @override
  _i4.Stream<_i2.AuthState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i4.Stream<_i2.AuthState>.empty(),
      ) as _i4.Stream<_i2.AuthState>);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);

  @override
  _i4.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  void add(_i2.AuthEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onEvent(_i2.AuthEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void emit(_i2.AuthState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void on<E extends _i2.AuthEvent>(
    _i5.EventHandler<E, _i2.AuthState>? handler, {
    _i5.EventTransformer<E>? transformer,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #on,
          [handler],
          {#transformer: transformer},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onTransition(_i5.Transition<_i2.AuthEvent, _i2.AuthState>? transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onChange(_i5.Change<_i2.AuthState>? change) => super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [FavoriteBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockFavoriteBloc extends _i1.Mock implements _i6.FavoriteBloc {
  MockFavoriteBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.FavoriteState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _i3.dummyValue<_i6.FavoriteState>(
          this,
          Invocation.getter(#state),
        ),
      ) as _i6.FavoriteState);

  @override
  _i4.Stream<_i6.FavoriteState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i4.Stream<_i6.FavoriteState>.empty(),
      ) as _i4.Stream<_i6.FavoriteState>);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);

  @override
  void add(_i6.FavoriteEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onEvent(_i6.FavoriteEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void emit(_i6.FavoriteState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void on<E extends _i6.FavoriteEvent>(
    _i5.EventHandler<E, _i6.FavoriteState>? handler, {
    _i5.EventTransformer<E>? transformer,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #on,
          [handler],
          {#transformer: transformer},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onTransition(
          _i5.Transition<_i6.FavoriteEvent, _i6.FavoriteState>? transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  void onChange(_i5.Change<_i6.FavoriteState>? change) => super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [PublicChatsBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockPublicChatsBloc extends _i1.Mock implements _i7.PublicChatsBloc {
  MockPublicChatsBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.PublicChatsState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _i3.dummyValue<_i7.PublicChatsState>(
          this,
          Invocation.getter(#state),
        ),
      ) as _i7.PublicChatsState);

  @override
  _i4.Stream<_i7.PublicChatsState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i4.Stream<_i7.PublicChatsState>.empty(),
      ) as _i4.Stream<_i7.PublicChatsState>);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);

  @override
  _i4.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void add(_i7.PublicChatsEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onEvent(_i7.PublicChatsEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void emit(_i7.PublicChatsState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void on<E extends _i7.PublicChatsEvent>(
    _i5.EventHandler<E, _i7.PublicChatsState>? handler, {
    _i5.EventTransformer<E>? transformer,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #on,
          [handler],
          {#transformer: transformer},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onTransition(
          _i5.Transition<_i7.PublicChatsEvent, _i7.PublicChatsState>?
              transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onChange(_i5.Change<_i7.PublicChatsState>? change) => super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [IModularNavigator].
///
/// See the documentation for Mockito's code generation for more information.
class MockIModularNavigator extends _i1.Mock implements _i8.IModularNavigator {
  MockIModularNavigator() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get path => (super.noSuchMethod(
        Invocation.getter(#path),
        returnValue: _i3.dummyValue<String>(
          this,
          Invocation.getter(#path),
        ),
      ) as String);

  @override
  List<_i8.ParallelRoute<dynamic>> get navigateHistory => (super.noSuchMethod(
        Invocation.getter(#navigateHistory),
        returnValue: <_i8.ParallelRoute<dynamic>>[],
      ) as List<_i8.ParallelRoute<dynamic>>);

  @override
  _i4.Future<T?> push<T extends Object?>(_i9.Route<T>? route) =>
      (super.noSuchMethod(
        Invocation.method(
          #push,
          [route],
        ),
        returnValue: _i4.Future<T?>.value(),
      ) as _i4.Future<T?>);

  @override
  _i4.Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(
    String? routeName, {
    TO? result,
    Object? arguments,
    bool? forRoot = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #popAndPushNamed,
          [routeName],
          {
            #result: result,
            #arguments: arguments,
            #forRoot: forRoot,
          },
        ),
        returnValue: _i4.Future<T?>.value(),
      ) as _i4.Future<T?>);

  @override
  _i4.Future<T?> pushNamed<T extends Object?>(
    String? routeName, {
    Object? arguments,
    bool? forRoot = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #pushNamed,
          [routeName],
          {
            #arguments: arguments,
            #forRoot: forRoot,
          },
        ),
        returnValue: _i4.Future<T?>.value(),
      ) as _i4.Future<T?>);

  @override
  _i4.Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String? newRouteName,
    bool Function(_i9.Route<dynamic>)? predicate, {
    Object? arguments,
    bool? forRoot = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #pushNamedAndRemoveUntil,
          [
            newRouteName,
            predicate,
          ],
          {
            #arguments: arguments,
            #forRoot: forRoot,
          },
        ),
        returnValue: _i4.Future<T?>.value(),
      ) as _i4.Future<T?>);

  @override
  _i4.Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String? routeName, {
    TO? result,
    Object? arguments,
    bool? forRoot = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #pushReplacementNamed,
          [routeName],
          {
            #result: result,
            #arguments: arguments,
            #forRoot: forRoot,
          },
        ),
        returnValue: _i4.Future<T?>.value(),
      ) as _i4.Future<T?>);

  @override
  void pop<T extends Object?>([T? result]) => super.noSuchMethod(
        Invocation.method(
          #pop,
          [result],
        ),
        returnValueForMissingStub: null,
      );

  @override
  bool canPop() => (super.noSuchMethod(
        Invocation.method(
          #canPop,
          [],
        ),
        returnValue: false,
      ) as bool);

  @override
  _i4.Future<bool> maybePop<T extends Object?>([T? result]) =>
      (super.noSuchMethod(
        Invocation.method(
          #maybePop,
          [result],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  void popUntil(bool Function(_i9.Route<dynamic>)? predicate) =>
      super.noSuchMethod(
        Invocation.method(
          #popUntil,
          [predicate],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void navigate(
    String? path, {
    dynamic arguments,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #navigate,
          [path],
          {#arguments: arguments},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void setObservers(List<_i9.NavigatorObserver>? navigatorObservers) =>
      super.noSuchMethod(
        Invocation.method(
          #setObservers,
          [navigatorObservers],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void setNavigatorKey(_i9.GlobalKey<_i9.NavigatorState>? navigatorkey) =>
      super.noSuchMethod(
        Invocation.method(
          #setNavigatorKey,
          [navigatorkey],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addListener(_i10.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i10.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
}
