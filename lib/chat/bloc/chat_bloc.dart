import 'dart:io';

import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/chat/domain/repo/chat_repository.dart';
import 'package:askimam/chat/domain/repo/message_repository.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/home/chats/bloc/my_chats_bloc.dart';
import 'package:askimam/home/chats/bloc/unanswered_chats_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _repo;
  final MessageRepository _messageRepo;
  final AuthBloc _authBloc;
  final MyChatsBloc _myChatsBloc;
  final UnansweredChatsBloc _unansweredChatsBloc;

  ChatBloc(
    this._repo,
    this._messageRepo,
    this._authBloc,
    this._myChatsBloc,
    this._unansweredChatsBloc,
  ) : super(const ChatStateInProgress()) {
    on<ChatEventRefresh>((event, emit) async {
      emit(const ChatStateInProgress());

      final result = await _repo.get(event.id);

      await result.fold(
        (l) async => emit(ChatStateError(l)),
        (r) async {
          switch (_authBloc.state) {
            case AuthStateAuthenticated(authentication: final auth):
              if (auth.userId == r.askedBy || auth.userType == UserType.Imam) {
                final setViewedFlagResult = await _repo.setViewedFlag(event.id);

                setViewedFlagResult.fold(
                  () {
                    _myChatsBloc.add(const MyChatsEventReload());

                    if (auth.userType == UserType.Imam) {
                      _unansweredChatsBloc.add(
                        const UnansweredChatsEventReload(),
                      );
                    }

                    emit(ChatStateSuccess(r, isSuccess: true));
                  },
                  (a) => emit(ChatStateError(a)),
                );
              } else {
                emit(ChatStateSuccess(r, isSuccess: true));
              }

            default:
              emit(ChatStateSuccess(r, isSuccess: true));
          }
        },
      );
    });

    on<ChatEventAddText>((event, emit) async {
      if (state case ChatStateSuccess(chat: final chat)) {
        emit(ChatStateSuccess(chat, isInProgress: true));

        final result = await _messageRepo.addText(chat.id, event.text);

        await result.fold(
          () async {
            final updateResult = await _repo.get(chat.id);

            emit(updateResult.fold(
              (l) => ChatStateSuccess(chat, rejection: l),
              (r) => ChatStateSuccess(r, isSuccess: true),
            ));
          },
          (a) {
            emit(ChatStateSuccess(chat, rejection: a));
          },
        );
      }
    });

    on<ChatEventAddAudio>((event, emit) async {
      if (state case ChatStateSuccess(chat: final chat)) {
        emit(ChatStateSuccess(chat, isInProgress: true));

        final result = await _messageRepo.addAudio(
          chat.id,
          event.file,
          event.duration,
        );
        if (event.file.path != 'audio.mp3') event.file.deleteSync();

        await result.fold(
          () async {
            final updateResult = await _repo.get(chat.id);

            emit(updateResult.fold(
              (l) => ChatStateSuccess(chat, rejection: l),
              (r) => ChatStateSuccess(r, isSuccess: true),
            ));
          },
          (a) {
            emit(ChatStateSuccess(chat, rejection: a));
          },
        );
      }
    });

    on<ChatEventUpdateTextMessage>((event, emit) async {
      if (state case ChatStateSuccess(chat: final chat)) {
        emit(ChatStateSuccess(chat, isInProgress: true));

        final result = await _messageRepo.updateText(
          chat.id,
          event.id,
          event.text,
        );

        emit(result.fold(
          () => ChatStateSuccess(
            chat.copyWith(
              messages: chat.messages
                  ?.map((m) =>
                      m.id == event.id ? m.copyWith(text: event.text) : m)
                  .toList(),
            ),
          ),
          (a) => ChatStateSuccess(chat, rejection: a),
        ));
      }
    });

    on<ChatEventDeleteMessage>((event, emit) async {
      if (state case ChatStateSuccess(chat: final chat)) {
        emit(ChatStateSuccess(
          chat.copyWith(
            messages: chat.messages
                ?.where((element) => element.id != event.id)
                .toList(),
          ),
          isInProgress: true,
        ));

        final result = await _messageRepo.delete(chat.id, event.id);

        emit(result.fold(
          () => ChatStateSuccess(chat.copyWith(
              messages:
                  chat.messages?.where((m) => m.id != event.id).toList())),
          (a) => ChatStateSuccess(chat, rejection: a),
        ));
      }
    });

    on<ChatEventUpdateSubject>((event, emit) async {
      if (state case ChatStateSuccess(chat: final chat)) {
        emit(ChatStateSuccess(chat, isInProgress: true));

        final result = await _repo.updateSubject(chat.id, event.subject);

        emit(result.fold(
          () => ChatStateSuccess(chat, isSuccess: true),
          (a) => ChatStateSuccess(chat, rejection: a),
        ));
      }
    });

    on<ChatEventReturnToUnaswered>((event, emit) async {
      if (state case ChatStateSuccess(chat: final chat)) {
        emit(ChatStateSuccess(chat, isInProgress: true));

        final result = await _repo.returnToUnanswered(chat.id);

        emit(result.fold(
          () => ChatStateSuccess(chat, isSuccess: true),
          (a) => ChatStateSuccess(chat, rejection: a),
        ));
      }
    });
  }
}
