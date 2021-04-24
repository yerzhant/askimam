import 'dart:async';

import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/chat/domain/repo/chat_repository.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/home/favorites/bloc/favorite_bloc.dart';
import 'package:askimam/home/favorites/domain/model/favorite.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_chats_bloc.freezed.dart';
part 'my_chats_event.dart';
part 'my_chats_state.dart';

class MyChatsBloc extends Bloc<MyChatsEvent, MyChatsState> {
  final ChatRepository _repo;
  final FavoriteBloc _favoriteBloc;
  final int _pageSize;
  late StreamSubscription _subscription;

  MyChatsBloc(
    this._repo,
    this._favoriteBloc,
    this._pageSize,
  ) : super(const _InProgress([])) {
    _subscription = _favoriteBloc.stream.listen((state) {
      state.maybeWhen(
        (favorites) => add(MyChatsEvent.updateFavorites(favorites)),
        orElse: () {},
      );
    });
  }

  @override
  Stream<MyChatsState> mapEventToState(MyChatsEvent event) => event.when(
        add: _add,
        show: _show,
        delete: _delete,
        reload: _reload,
        loadNextPage: _loadNextPage,
        updateFavorites: _updateFavorites,
      );

  Stream<MyChatsState> _show() async* {
    state.maybeWhen(
      (chats) async* {
        yield MyChatsState(chats);
      },
      orElse: () => add(const MyChatsEvent.reload()),
    );
  }

  Stream<MyChatsState> _reload() async* {
    yield const MyChatsState.inProgress([]);

    final result = await _repo.getMy(0, _pageSize);

    yield result.fold(
      (l) => MyChatsState.error(l),
      (r) => MyChatsState(r),
    );
  }

  Stream<MyChatsState> _loadNextPage() async* {
    Stream<MyChatsState> load(List<Chat> chats) async* {
      yield MyChatsState.inProgress(chats);

      final result = await _repo.getMy(chats.length, _pageSize);

      yield result.fold(
        (l) => MyChatsState.error(l),
        (r) => MyChatsState(chats..addAll(r)),
      );
    }

    yield* state.maybeWhen(
      (chats) => load(chats),
      orElse: () async* {
        yield state;
      },
    );
  }

  Stream<MyChatsState> _add(
    ChatType type,
    String? subject,
    String text,
  ) async* {
    yield* state.maybeWhen(
      (chats) async* {
        yield MyChatsState.inProgress(chats);

        final result = await _repo.add(type, subject, text);

        yield* result.fold(
          () async* {
            add(const MyChatsEvent.reload());
          },
          (a) async* {
            yield MyChatsState.error(a);
          },
        );
      },
      orElse: () async* {
        yield state;
      },
    );
  }

  Stream<MyChatsState> _delete(Chat chat) async* {
    yield* state.maybeWhen(
      (chats) async* {
        yield MyChatsState.inProgress(chats);

        final result = await _repo.delete(chat);

        yield result.fold(
          () => MyChatsState(chats.where((c) => c.id != chat.id).toList()),
          (a) => MyChatsState.error(a),
        );
      },
      orElse: () async* {
        yield state;
      },
    );
  }

  Stream<MyChatsState> _updateFavorites(List<Favorite> favorites) async* {
    yield state.maybeWhen(
      (chats) => MyChatsState(chats
          .map(
            (chat) => chat.copyWith(
              isFavorite: favorites.any((f) => f.chatId == chat.id),
            ),
          )
          .toList()),
      orElse: () => state,
    );
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
