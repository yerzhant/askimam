import 'package:askimam/auth/auth_module.dart';
import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:askimam/auth/infra/http_auth_repository.dart';
import 'package:askimam/chat/chat_module.dart';
import 'package:askimam/common/infra/fcm_service.dart';
import 'package:askimam/common/infra/http_api_client.dart';
import 'package:askimam/common/infra/local_storage.dart';
import 'package:askimam/home/home_module.dart';
import 'package:askimam/imam_ratings/imam_ratings_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';

class AppModule extends Module {
  final String _url;

  AppModule(this._url);

  @override
  void binds(Injector i) {
    i.addSingleton(() => Client());
    i.addSingleton(() => FcmService());
    i.addSingleton(() => LocalStorage());
    i.addSingleton(() => HttpApiClient(i(), _url));
    i.addSingleton(() => HttpAuthRepository(i(), i()));
    i.addSingleton(() => AuthBloc(i(), i(), i()));
  }

  @override
  void routes(RouteManager r) {
    r.module('/', module: HomeModule());
    r.module('/chat', module: ChatModule());
    r.module('/auth', module: AuthModule());
    r.module('/imam-ratings', module: ImamRatingsModule());
  }
}
