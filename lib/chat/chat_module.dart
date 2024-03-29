import 'package:askimam/chat/bloc/chat_bloc.dart';
import 'package:askimam/chat/domain/repo/message_repository.dart';
import 'package:askimam/chat/infra/http_chat_repository.dart';
import 'package:askimam/chat/infra/http_message_repository.dart';
import 'package:askimam/chat/ui/chat_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:logger/logger.dart';

class ChatModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(() => HttpChatRepository(i(), i()));
    i.addSingleton<MessageRepository>(() => HttpMessageRepository(i(), i()));
    i.addSingleton(() => ChatBloc(i(), i(), i(), i(), i()));
    i.addSingleton(() => FlutterSoundRecorder(logLevel: Level.warning));
  }

  @override
  void routes(r) {
    r.child(
      '/:id',
      child: (_) => ChatPage(
        int.parse(r.args.params['id']),
        Modular.get(),
        Modular.get(),
        Modular.get(),
      ),
    );
  }
}
