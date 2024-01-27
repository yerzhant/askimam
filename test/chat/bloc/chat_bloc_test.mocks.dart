// Mocks generated by Mockito 5.4.4 from annotations
// in askimam/test/chat/bloc/chat_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:io' as _i12;

import 'package:askimam/auth/bloc/auth_bloc.dart' as _i3;
import 'package:askimam/chat/domain/model/chat.dart' as _i10;
import 'package:askimam/chat/domain/repo/chat_repository.dart' as _i8;
import 'package:askimam/chat/domain/repo/message_repository.dart' as _i11;
import 'package:askimam/common/domain/model/rejection.dart' as _i9;
import 'package:askimam/home/chats/bloc/my_chats_bloc.dart' as _i7;
import 'package:askimam/home/chats/bloc/unanswered_chats_bloc.dart' as _i13;
import 'package:bloc/bloc.dart' as _i6;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i4;

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

/// A class which mocks [AuthBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthBloc extends _i1.Mock implements _i3.AuthBloc {
  MockAuthBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.AuthState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _i4.dummyValue<_i3.AuthState>(
          this,
          Invocation.getter(#state),
        ),
      ) as _i3.AuthState);

  @override
  _i5.Stream<_i3.AuthState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i5.Stream<_i3.AuthState>.empty(),
      ) as _i5.Stream<_i3.AuthState>);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);

  @override
  void add(_i3.AuthEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onEvent(_i3.AuthEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void emit(_i3.AuthState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void on<E extends _i3.AuthEvent>(
    _i6.EventHandler<E, _i3.AuthState>? handler, {
    _i6.EventTransformer<E>? transformer,
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
  void onTransition(_i6.Transition<_i3.AuthEvent, _i3.AuthState>? transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i5.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  void onChange(_i6.Change<_i3.AuthState>? change) => super.noSuchMethod(
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

/// A class which mocks [MyChatsBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockMyChatsBloc extends _i1.Mock implements _i7.MyChatsBloc {
  MockMyChatsBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.MyChatsState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _i4.dummyValue<_i7.MyChatsState>(
          this,
          Invocation.getter(#state),
        ),
      ) as _i7.MyChatsState);

  @override
  _i5.Stream<_i7.MyChatsState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i5.Stream<_i7.MyChatsState>.empty(),
      ) as _i5.Stream<_i7.MyChatsState>);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);

  @override
  _i5.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void add(_i7.MyChatsEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onEvent(_i7.MyChatsEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void emit(_i7.MyChatsState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void on<E extends _i7.MyChatsEvent>(
    _i6.EventHandler<E, _i7.MyChatsState>? handler, {
    _i6.EventTransformer<E>? transformer,
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
          _i6.Transition<_i7.MyChatsEvent, _i7.MyChatsState>? transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onChange(_i6.Change<_i7.MyChatsState>? change) => super.noSuchMethod(
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

/// A class which mocks [ChatRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockChatRepository extends _i1.Mock implements _i8.ChatRepository {
  MockChatRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Either<_i9.Rejection, _i10.Chat>> get(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [id],
        ),
        returnValue: _i5.Future<_i2.Either<_i9.Rejection, _i10.Chat>>.value(
            _FakeEither_0<_i9.Rejection, _i10.Chat>(
          this,
          Invocation.method(
            #get,
            [id],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i9.Rejection, _i10.Chat>>);

  @override
  _i5.Future<_i2.Either<_i9.Rejection, List<_i10.Chat>>> find(String? phrase) =>
      (super.noSuchMethod(
        Invocation.method(
          #find,
          [phrase],
        ),
        returnValue:
            _i5.Future<_i2.Either<_i9.Rejection, List<_i10.Chat>>>.value(
                _FakeEither_0<_i9.Rejection, List<_i10.Chat>>(
          this,
          Invocation.method(
            #find,
            [phrase],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i9.Rejection, List<_i10.Chat>>>);

  @override
  _i5.Future<_i2.Either<_i9.Rejection, List<_i10.Chat>>> getMy(
    int? offset,
    int? pageSize,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMy,
          [
            offset,
            pageSize,
          ],
        ),
        returnValue:
            _i5.Future<_i2.Either<_i9.Rejection, List<_i10.Chat>>>.value(
                _FakeEither_0<_i9.Rejection, List<_i10.Chat>>(
          this,
          Invocation.method(
            #getMy,
            [
              offset,
              pageSize,
            ],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i9.Rejection, List<_i10.Chat>>>);

  @override
  _i5.Future<_i2.Either<_i9.Rejection, List<_i10.Chat>>> getPublic(
    int? offset,
    int? pageSize,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPublic,
          [
            offset,
            pageSize,
          ],
        ),
        returnValue:
            _i5.Future<_i2.Either<_i9.Rejection, List<_i10.Chat>>>.value(
                _FakeEither_0<_i9.Rejection, List<_i10.Chat>>(
          this,
          Invocation.method(
            #getPublic,
            [
              offset,
              pageSize,
            ],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i9.Rejection, List<_i10.Chat>>>);

  @override
  _i5.Future<_i2.Either<_i9.Rejection, List<_i10.Chat>>> getUnanswered(
    int? offset,
    int? pageSize,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUnanswered,
          [
            offset,
            pageSize,
          ],
        ),
        returnValue:
            _i5.Future<_i2.Either<_i9.Rejection, List<_i10.Chat>>>.value(
                _FakeEither_0<_i9.Rejection, List<_i10.Chat>>(
          this,
          Invocation.method(
            #getUnanswered,
            [
              offset,
              pageSize,
            ],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i9.Rejection, List<_i10.Chat>>>);

  @override
  _i5.Future<_i2.Option<_i9.Rejection>> add(
    _i10.ChatType? type,
    String? subject,
    String? text,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #add,
          [
            type,
            subject,
            text,
          ],
        ),
        returnValue: _i5.Future<_i2.Option<_i9.Rejection>>.value(
            _FakeOption_1<_i9.Rejection>(
          this,
          Invocation.method(
            #add,
            [
              type,
              subject,
              text,
            ],
          ),
        )),
      ) as _i5.Future<_i2.Option<_i9.Rejection>>);

  @override
  _i5.Future<_i2.Option<_i9.Rejection>> updateSubject(
    int? id,
    String? subject,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateSubject,
          [
            id,
            subject,
          ],
        ),
        returnValue: _i5.Future<_i2.Option<_i9.Rejection>>.value(
            _FakeOption_1<_i9.Rejection>(
          this,
          Invocation.method(
            #updateSubject,
            [
              id,
              subject,
            ],
          ),
        )),
      ) as _i5.Future<_i2.Option<_i9.Rejection>>);

  @override
  _i5.Future<_i2.Option<_i9.Rejection>> delete(_i10.Chat? chat) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [chat],
        ),
        returnValue: _i5.Future<_i2.Option<_i9.Rejection>>.value(
            _FakeOption_1<_i9.Rejection>(
          this,
          Invocation.method(
            #delete,
            [chat],
          ),
        )),
      ) as _i5.Future<_i2.Option<_i9.Rejection>>);

  @override
  _i5.Future<_i2.Option<_i9.Rejection>> setViewedFlag(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #setViewedFlag,
          [id],
        ),
        returnValue: _i5.Future<_i2.Option<_i9.Rejection>>.value(
            _FakeOption_1<_i9.Rejection>(
          this,
          Invocation.method(
            #setViewedFlag,
            [id],
          ),
        )),
      ) as _i5.Future<_i2.Option<_i9.Rejection>>);

  @override
  _i5.Future<_i2.Option<_i9.Rejection>> returnToUnanswered(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #returnToUnanswered,
          [id],
        ),
        returnValue: _i5.Future<_i2.Option<_i9.Rejection>>.value(
            _FakeOption_1<_i9.Rejection>(
          this,
          Invocation.method(
            #returnToUnanswered,
            [id],
          ),
        )),
      ) as _i5.Future<_i2.Option<_i9.Rejection>>);
}

/// A class which mocks [MessageRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMessageRepository extends _i1.Mock implements _i11.MessageRepository {
  MockMessageRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Option<_i9.Rejection>> addText(
    int? chatId,
    String? text,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addText,
          [
            chatId,
            text,
          ],
        ),
        returnValue: _i5.Future<_i2.Option<_i9.Rejection>>.value(
            _FakeOption_1<_i9.Rejection>(
          this,
          Invocation.method(
            #addText,
            [
              chatId,
              text,
            ],
          ),
        )),
      ) as _i5.Future<_i2.Option<_i9.Rejection>>);

  @override
  _i5.Future<_i2.Option<_i9.Rejection>> addAudio(
    int? chatId,
    _i12.File? audio,
    String? duration,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addAudio,
          [
            chatId,
            audio,
            duration,
          ],
        ),
        returnValue: _i5.Future<_i2.Option<_i9.Rejection>>.value(
            _FakeOption_1<_i9.Rejection>(
          this,
          Invocation.method(
            #addAudio,
            [
              chatId,
              audio,
              duration,
            ],
          ),
        )),
      ) as _i5.Future<_i2.Option<_i9.Rejection>>);

  @override
  _i5.Future<_i2.Option<_i9.Rejection>> delete(
    int? chatId,
    int? messageId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [
            chatId,
            messageId,
          ],
        ),
        returnValue: _i5.Future<_i2.Option<_i9.Rejection>>.value(
            _FakeOption_1<_i9.Rejection>(
          this,
          Invocation.method(
            #delete,
            [
              chatId,
              messageId,
            ],
          ),
        )),
      ) as _i5.Future<_i2.Option<_i9.Rejection>>);

  @override
  _i5.Future<_i2.Option<_i9.Rejection>> updateText(
    int? chatId,
    int? messageId,
    String? text,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateText,
          [
            chatId,
            messageId,
            text,
          ],
        ),
        returnValue: _i5.Future<_i2.Option<_i9.Rejection>>.value(
            _FakeOption_1<_i9.Rejection>(
          this,
          Invocation.method(
            #updateText,
            [
              chatId,
              messageId,
              text,
            ],
          ),
        )),
      ) as _i5.Future<_i2.Option<_i9.Rejection>>);
}

/// A class which mocks [UnansweredChatsBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockUnansweredChatsBloc extends _i1.Mock
    implements _i13.UnansweredChatsBloc {
  MockUnansweredChatsBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i13.UnansweredChatsState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _i4.dummyValue<_i13.UnansweredChatsState>(
          this,
          Invocation.getter(#state),
        ),
      ) as _i13.UnansweredChatsState);

  @override
  _i5.Stream<_i13.UnansweredChatsState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i5.Stream<_i13.UnansweredChatsState>.empty(),
      ) as _i5.Stream<_i13.UnansweredChatsState>);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);

  @override
  void add(_i13.UnansweredChatsEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onEvent(_i13.UnansweredChatsEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void emit(_i13.UnansweredChatsState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void on<E extends _i13.UnansweredChatsEvent>(
    _i6.EventHandler<E, _i13.UnansweredChatsState>? handler, {
    _i6.EventTransformer<E>? transformer,
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
          _i6.Transition<_i13.UnansweredChatsEvent, _i13.UnansweredChatsState>?
              transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i5.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  void onChange(_i6.Change<_i13.UnansweredChatsState>? change) =>
      super.noSuchMethod(
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
