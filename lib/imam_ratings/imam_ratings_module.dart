import 'package:askimam/imam_ratings/bloc/imam_ratings_bloc.dart';
import 'package:askimam/imam_ratings/domain/repo/imam_ratings_repo.dart';
import 'package:askimam/imam_ratings/infra/http_imam_ratings_repo.dart';
import 'package:askimam/imam_ratings/ui/imam_ratings_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ImamRatingsModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<ImamRatingsRepo>(() => HttpImamRatingsRepo(i()));
    i.addSingleton(() => ImamRatingsBloc(i()));
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => ImamRatingsPage(bloc: Modular.get()));
  }
}
