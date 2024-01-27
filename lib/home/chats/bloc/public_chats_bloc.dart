import 'dart:async';

import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/chat/domain/repo/chat_repository.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/home/favorites/bloc/favorite_bloc.dart';
import 'package:askimam/home/favorites/domain/model/favorite.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'public_chats_event.dart';
part 'public_chats_state.dart';

class PublicChatsBloc extends Bloc<PublicChatsEvent, PublicChatsState>
    implements Disposable {
  final ChatRepository _repo;
  final FavoriteBloc _favoriteBloc;
  final int _pageSize;
  late StreamSubscription _subscription;

  PublicChatsBloc(
    this._repo,
    this._favoriteBloc,
    this._pageSize,
  ) : super(const PublicChatsStateInProgress([])) {
    _subscription = _favoriteBloc.stream.listen((state) {
      if (state case FavoriteStateSuccess(favorites: final favorites)) {
        add(PublicChatsEventUpdateFavorites(favorites));
      }
    });

    on<PublicChatsEventShow>((event, emit) {
      if (state is! PublicChatsStateSuccess) {
        add(const PublicChatsEventReload());
      }
    });

    on<PublicChatsEventReload>((event, emit) async {
      emit(const PublicChatsStateInProgress([]));

      final result = await _repo.getPublic(0, _pageSize);

      emit(result.fold(
        (l) => PublicChatsStateError(l),
        (r) => PublicChatsStateSuccess(r),
      ));
    });

    on<PublicChatsEventLoadNextPage>((event, emit) async {
      if (state case PublicChatsStateSuccess(chats: final chats)) {
        emit(PublicChatsStateInProgress(chats));

        final page = chats.length ~/ _pageSize;
        final result = await _repo.getPublic(page, _pageSize);

        emit(result.fold(
          (l) => PublicChatsStateError(l),
          (r) => PublicChatsStateSuccess(chats..addAll(r)),
        ));
      }
    });

    on<PublicChatsEventUpdateFavorites>((event, emit) {
      if (state case PublicChatsStateSuccess(chats: final chats)) {
        emit(PublicChatsStateSuccess(chats
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
