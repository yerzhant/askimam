import 'dart:async';

import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/imam_ratings/domain/model/imam_rating.dart';
import 'package:askimam/imam_ratings/domain/repo/imam_ratings_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'imam_ratings_event.dart';
part 'imam_ratings_state.dart';
part 'imam_ratings_bloc.freezed.dart';

class ImamRatingsBloc extends Bloc<ImamRatingsEvent, ImamRatingsState> {
  final ImamRatingsRepo _repo;

  ImamRatingsBloc(this._repo) : super(const _InProgress());

  @override
  Stream<ImamRatingsState> mapEventToState(ImamRatingsEvent event) =>
      event.map(reload: _reload);

  Stream<ImamRatingsState> _reload(_Reload event) async* {
    yield const ImamRatingsState.inProgress();

    final result = await _repo.getRatings();

    yield result.fold(
      (l) => ImamRatingsState.error(l),
      (r) => ImamRatingsState(r),
    );
  }
}
