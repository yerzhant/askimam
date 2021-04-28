import 'package:askimam/chat/infra/http_chat_repository.dart';
import 'package:askimam/common/infra/fcm_service.dart';
import 'package:askimam/common/ui/ui_constants.dart';
import 'package:askimam/home/chats/bloc/my_chats_bloc.dart';
import 'package:askimam/home/chats/bloc/public_chats_bloc.dart';
import 'package:askimam/home/chats/bloc/unanswered_chats_bloc.dart';
import 'package:askimam/home/chats/ui/new_question_page.dart';
import 'package:askimam/home/favorites/bloc/favorite_bloc.dart';
import 'package:askimam/home/favorites/infra/http_favorite_repository.dart';
import 'package:askimam/home/ui/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => FcmService()),
        Bind.singleton((i) => HttpChatRepository(i(), i())),
        Bind.singleton((i) => HttpFavoriteRepository(i())),
        Bind.singleton((i) => FavoriteBloc(i())),
        Bind.singleton((i) => UnansweredChatsBloc(i(), pageSize)),
        Bind.singleton((i) => MyChatsBloc(i(), i(), pageSize)),
        Bind.singleton((i) => PublicChatsBloc(i(), i(), pageSize)),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, __) => HomePage(
            unansweredChatsBloc: Modular.get(),
            myChatsBloc: Modular.get(),
            publicChatsBloc: Modular.get(),
            favoriteBloc: Modular.get(),
            authBloc: Modular.get(),
          ),
        ),
        ChildRoute('/new-question',
            child: (_, __) => NewQuestionPage(Modular.get())),
      ];
}
