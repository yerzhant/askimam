import 'package:askimam/imam_ratings/bloc/imam_ratings_bloc.dart';
import 'package:askimam/imam_ratings/domain/repo/imam_ratings_repo.dart';
import 'package:askimam/imam_ratings/infra/http_imam_ratings_repo.dart';
import 'package:askimam/imam_ratings/ui/imam_ratings_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ImamRatingsModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => HttpImamRatingsRepo(i())),
        Bind.singleton((i) => ImamRatingsBloc(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => ImamRatingsPage(bloc: Modular.get())),
      ];
}
