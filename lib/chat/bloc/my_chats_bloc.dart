import 'dart:async';

import 'package:askimam/chat/domain/chat.dart';
import 'package:askimam/chat/domain/chat_repository.dart';
import 'package:askimam/common/domain/rejection.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_chats_event.dart';
part 'my_chats_state.dart';
part 'my_chats_bloc.freezed.dart';

class MyChatsBloc extends Bloc<MyChatsEvent, MyChatsState> {
  final ChatRepository _repo;
  final int _pageSize;

  MyChatsBloc(this._repo, this._pageSize) : super(_InProgress([]));

  @override
  Stream<MyChatsState> mapEventToState(MyChatsEvent event) => event.when(
        show: _show,
        reload: _reload,
        loadNextPage: _loadNextPage,
      );

  Stream<MyChatsState> _show() async* {
    state.maybeWhen(
      (chats) async* {
        yield MyChatsState(chats);
      },
      orElse: () => add(MyChatsEvent.reload()),
    );
  }

  Stream<MyChatsState> _reload() async* {
    yield MyChatsState.inProgress([]);

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

    yield* state.when(
      (chats) => load(chats),
      inProgress: (chats) async* {
        yield MyChatsState.inProgress(chats);
      },
      error: (rejection) async* {
        yield MyChatsState.error(rejection);
      },
    );
  }
}
