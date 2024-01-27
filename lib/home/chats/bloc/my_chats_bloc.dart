import 'dart:async';

import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/chat/domain/repo/chat_repository.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/home/favorites/bloc/favorite_bloc.dart';
import 'package:askimam/home/favorites/domain/model/favorite.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'my_chats_event.dart';
part 'my_chats_state.dart';

class MyChatsBloc extends Bloc<MyChatsEvent, MyChatsState>
    implements Disposable {
  final ChatRepository _repo;
  final FavoriteBloc _favoriteBloc;
  final int _pageSize;
  late StreamSubscription _subscription;

  MyChatsBloc(
    this._repo,
    this._favoriteBloc,
    this._pageSize,
  ) : super(const MyChatsStateInProgress([])) {
    _subscription = _favoriteBloc.stream.listen((state) {
      if (state case FavoriteStateSuccess(favorites: final favorites)) {
        add(MyChatsEventUpdateFavorites(favorites));
      }
    });

    on<MyChatsEventShow>((event, emit) {
      if (state is! MyChatsStateSuccess) {
        add(const MyChatsEventReload());
      }
    });

    on<MyChatsEventReload>((event, emit) async {
      emit(const MyChatsStateInProgress([]));

      final result = await _repo.getMy(0, _pageSize);

      emit(result.fold(
        (l) => MyChatsStateError(l),
        (r) => MyChatsStateSuccess(r),
      ));
    });

    on<MyChatsEventLoadNextPage>((event, emit) async {
      if (state case MyChatsStateSuccess(chats: final chats)) {
        emit(MyChatsStateInProgress(chats));

        final page = chats.length ~/ _pageSize;
        final result = await _repo.getMy(page, _pageSize);

        emit(result.fold(
          (l) => MyChatsStateError(l),
          (r) => MyChatsStateSuccess(chats..addAll(r)),
        ));
      }
    });

    on<MyChatsEventAdd>((event, emit) async {
      if (state case MyChatsStateSuccess(chats: final chats)) {
        emit(MyChatsStateInProgress(chats));

        final result = await _repo.add(event.type, event.subject, event.text);

        result.fold(
          () => add(const MyChatsEventReload()),
          (a) => emit(MyChatsStateError(a)),
        );
      }
    });

    on<MyChatsEventDelete>((event, emit) async {
      if (state case MyChatsStateSuccess(chats: final chats)) {
        emit(MyChatsStateInProgress(chats));

        final result = await _repo.delete(event.chat);

        emit(result.fold(
          () {
            _favoriteBloc.add(const FavoriteEventRefresh());
            return MyChatsStateSuccess(
              chats.where((c) => c.id != event.chat.id).toList(),
            );
          },
          (a) => MyChatsStateError(a),
        ));
      }
    });

    on<MyChatsEventUpdateFavorites>((event, emit) {
      if (state case MyChatsStateSuccess(chats: final chats)) {
        emit(MyChatsStateSuccess(chats
            .map(
              (c) => c.copyWith(
                isFavorite: event.favorites.any((f) => f.chatId == c.id),
              ),
            )
            .toList()));
      }
    });
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }

  @override
  void dispose() => close();
}
