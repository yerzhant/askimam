import 'dart:async';

import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/chat/domain/repo/chat_repository.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_chats_bloc.freezed.dart';
part 'search_chats_event.dart';
part 'search_chats_state.dart';

class SearchChatsBloc extends Bloc<SearchChatsEvent, SearchChatsState> {
  final ChatRepository _repo;

  SearchChatsBloc(this._repo) : super(const _State([]));

  @override
  Stream<SearchChatsState> mapEventToState(SearchChatsEvent event) =>
      event.when(find: _find);

  Stream<SearchChatsState> _find(String phrase) async* {
    yield const SearchChatsState.inProgress();

    final result = await _repo.find(phrase);

    yield result.fold(
      (l) => SearchChatsState.error(l),
      (r) => SearchChatsState(r),
    );
  }
}
