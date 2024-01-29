import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/chat/domain/repo/chat_repository.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_chats_event.dart';
part 'search_chats_state.dart';

class SearchChatsBloc extends Bloc<SearchChatsEvent, SearchChatsState> {
  final ChatRepository _repo;

  SearchChatsBloc(this._repo) : super(const SearchChatsStateSuccess([])) {
    on<SearchChatsEventFind>((event, emit) async {
      emit(const SearchChatsStateInProgress());

      final result = await _repo.find(event.phrase);

      emit(result.fold(
        (l) => SearchChatsStateError(l),
        (r) => SearchChatsStateSuccess(r),
      ));
    });
  }
}
