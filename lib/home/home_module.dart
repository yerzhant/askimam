import 'package:askimam/chat/domain/repo/chat_repository.dart';
import 'package:askimam/chat/infra/http_chat_repository.dart';
import 'package:askimam/common/ui/ui_constants.dart';
import 'package:askimam/home/chats/bloc/my_chats_bloc.dart';
import 'package:askimam/home/chats/bloc/public_chats_bloc.dart';
import 'package:askimam/home/chats/bloc/unanswered_chats_bloc.dart';
import 'package:askimam/home/chats/ui/new_question_page.dart';
import 'package:askimam/home/favorites/bloc/favorite_bloc.dart';
import 'package:askimam/home/favorites/domain/repo/favorite_repository.dart';
import 'package:askimam/home/favorites/infra/http_favorite_repository.dart';
import 'package:askimam/home/search/bloc/search_chats_bloc.dart';
import 'package:askimam/home/ui/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<FavoriteRepository>(() => HttpFavoriteRepository(i()));
    i.addSingleton<ChatRepository>(() => HttpChatRepository(i(), i()));
    i.addSingleton(() => FavoriteBloc(i()));
    i.addSingleton(() => SearchChatsBloc(i()));
    i.addSingleton(() => MyChatsBloc(i(), i(), pageSize));
    i.addSingleton(() => UnansweredChatsBloc(i(), pageSize));
    i.addSingleton(() => PublicChatsBloc(i(), i(), pageSize));
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => HomePage(
        authBloc: Modular.get(),
        myChatsBloc: Modular.get(),
        favoriteBloc: Modular.get(),
        searchChatsBloc: Modular.get(),
        publicChatsBloc: Modular.get(),
        unansweredChatsBloc: Modular.get(),
      ),
    );

    r.child('/new-question', child: (_) => NewQuestionPage(Modular.get()));
  }
}
