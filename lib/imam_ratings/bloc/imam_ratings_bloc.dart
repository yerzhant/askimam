import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/imam_ratings/domain/model/imam_ratings_with_description.dart';
import 'package:askimam/imam_ratings/domain/repo/imam_ratings_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'imam_ratings_event.dart';
part 'imam_ratings_state.dart';

class ImamRatingsBloc extends Bloc<ImamRatingsEvent, ImamRatingsState> {
  final ImamRatingsRepo _repo;

  ImamRatingsBloc(this._repo) : super(const ImamRatingsStateInProgress()) {
    on<ImamRatingsEventReload>((event, emit) async {
      emit(const ImamRatingsStateInProgress());

      final result = await _repo.getRatings();

      emit(result.fold(
        (l) => ImamRatingsStateError(l),
        (r) => ImamRatingsStateSuccess(r),
      ));
    });
  }
}
