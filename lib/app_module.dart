import 'package:askimam/auth/auth_module.dart';
import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:askimam/auth/infra/http_auth_repository.dart';
import 'package:askimam/chat/chat_module.dart';
import 'package:askimam/common/infra/http_api_client.dart';
import 'package:askimam/common/infra/local_storage.dart';
import 'package:askimam/home/home_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/io_client.dart';

class AppModule extends Module {
  final String _url;

  AppModule(this._url);

  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => IOClient()),
        Bind.singleton((i) => LocalStorage()),
        Bind.singleton((i) => HttpApiClient(i(), _url)),
        Bind.singleton((i) => HttpAuthRepository(i(), i())),
        Bind.singleton((i) => AuthBloc(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: HomeModule()),
        ModuleRoute('/chat', module: ChatModule()),
        ModuleRoute('/auth', module: AuthModule()),
      ];
}
