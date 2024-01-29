import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/chat/domain/repo/chat_repository.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/home/favorites/domain/model/favorite.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'unanswered_chats_event.dart';
part 'unanswered_chats_state.dart';

class UnansweredChatsBloc
    extends Bloc<UnansweredChatsEvent, UnansweredChatsState> {
  final ChatRepository _repo;
  final int _pageSize;

  UnansweredChatsBloc(this._repo, this._pageSize)
      : super(const UnansweredChatsStateInProgress([])) {
    on<UnansweredChatsEventShow>((event, emit) {
      if (state is! UnansweredChatsStateSuccess) {
        add(const UnansweredChatsEventReload());
      }
    });

    on<UnansweredChatsEventReload>((event, emit) async {
      emit(const UnansweredChatsStateInProgress([]));

      final result = await _repo.getUnanswered(0, _pageSize);

      emit(result.fold(
        (l) => UnansweredChatsStateError(l),
        (r) => UnansweredChatsStateSuccess(r),
      ));
    });

    on<UnansweredChatsEventLoadNextPage>((event, emit) async {
      if (state case UnansweredChatsStateSuccess(chats: final chats)) {
        emit(UnansweredChatsStateInProgress(chats));

        final page = chats.length ~/ _pageSize;
        final result = await _repo.getUnanswered(page, _pageSize);

        emit(result.fold(
          (l) => UnansweredChatsStateError(l),
          (r) => UnansweredChatsStateSuccess(chats..addAll(r)),
        ));
      }
    });

    on<UnansweredChatsEventDelete>((event, emit) async {
      if (state case UnansweredChatsStateSuccess(chats: final chats)) {
        emit(UnansweredChatsStateInProgress(chats));

        final result = await _repo.delete(event.chat);

        emit(result.fold(
          () => UnansweredChatsStateSuccess(
            chats.where((c) => c.id != event.chat.id).toList(),
          ),
          (a) => UnansweredChatsStateError(a),
        ));
      }
    });

    on<UnansweredChatsEventUpdateFavorites>((event, emit) {
      if (state case UnansweredChatsStateSuccess(chats: final chats)) {
        emit(UnansweredChatsStateSuccess(chats
            .map(
              (c) => c.copyWith(
                isFavorite: event.favorites.any((f) => f.chatId == c.id),
              ),
            )
            .toList()));
      }
    });
  }
}
