import 'package:askimam/home/favorites/bloc/favorite_bloc.dart';
import 'package:askimam/home/favorites/infra/http_favorite_repository.dart';
import 'package:askimam/home/ui/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => HttpFavoriteRepository(i())),
        Bind.singleton((i) => FavoriteBloc(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => HomePage()),
        // ChildRoute('/new-question', child: (_, __) => NewQPage()),
      ];
}
