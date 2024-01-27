import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/home/favorites/domain/model/favorite.dart';
import 'package:askimam/home/favorites/domain/repo/favorite_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepository _repo;

  FavoriteBloc(this._repo) : super(const FavoriteStateInProgress([])) {
    on<FavoriteEventShow>((event, emit) {
      switch (state) {
        case FavoriteStateSuccess():
          break;

        default:
          add(const FavoriteEventRefresh());
      }
    });

    on<FavoriteEventRefresh>((event, emit) async {
      emit(const FavoriteStateInProgress([]));

      final result = await _repo.get();

      emit(result.fold(
        (l) => FavoriteStateError(l),
        (r) => FavoriteStateSuccess(r),
      ));
    });

    on<FavoriteEventAdd>((event, emit) {
      void addIt(List<Favorite> favorites) async {
        emit(FavoriteStateInProgress(favorites));

        final result = await _repo.add(event.chat);

        result.fold(
          () => add(const FavoriteEventRefresh()),
          (a) => emit(FavoriteStateError(a)),
        );
      }

      switch (state) {
        case FavoriteStateSuccess(favorites: final favorites):
          addIt(favorites);
        case FavoriteStateInProgress(favorites: final favorites):
          addIt(favorites);
        case FavoriteStateError():
          break;
      }
    });

    on<FavoriteEventDelete>((event, emit) {
      void delete(List<Favorite> favorites) async {
        emit(FavoriteStateInProgress(favorites));

        final result = await _repo.delete(event.chatId);

        emit(result.fold(
          () => FavoriteStateSuccess(
            favorites.where((f) => f.chatId != event.chatId).toList(),
          ),
          (a) => FavoriteStateError(a),
        ));
      }

      switch (state) {
        case FavoriteStateSuccess(favorites: final favorites):
          delete(favorites);
        case FavoriteStateInProgress(favorites: final favorites):
          delete(favorites);
        case FavoriteStateError():
          break;
      }
    });
  }
}
