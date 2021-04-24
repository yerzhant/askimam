import 'package:askimam/chat/bloc/chat_bloc.dart';
import 'package:askimam/chat/infra/http_chat_repository.dart';
import 'package:askimam/chat/infra/http_message_repository.dart';
import 'package:askimam/chat/ui/chat_page.dart';
import 'package:askimam/common/infra/fcm_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ChatModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => FcmService()),
        Bind.singleton((i) => HttpChatRepository(i(), i())),
        Bind.singleton((i) => HttpMessageRepository(i(), i())),
        Bind.singleton((i) => ChatBloc(i(), i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/:id',
          child: (_, args) => ChatPage(
            Modular.get<ChatBloc>(),
            args.params['id'],
          ),
        ),
      ];
}
