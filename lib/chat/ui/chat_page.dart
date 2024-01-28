import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/chat/bloc/chat_bloc.dart';
import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/chat/domain/model/message.dart';
import 'package:askimam/chat/ui/widget/message_card.dart';
import 'package:askimam/chat/ui/widget/message_composer.dart';
import 'package:askimam/common/ui/theme.dart';
import 'package:askimam/common/ui/widget/in_progress_widget.dart';
import 'package:askimam/common/ui/widget/rejection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;
import 'package:flutter_sound_lite/flutter_sound.dart';

const _messagePadding = 10.0;

class ChatPage extends StatefulWidget {
  final int id;
  final ChatBloc bloc;
  final AuthBloc authBloc;
  final FlutterSoundRecorder soundRecorder;

  ChatPage(this.id, this.bloc, this.authBloc, this.soundRecorder, {super.key}) {
    bloc.add(ChatEventRefresh(id));
  }

  @override
  State createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state
              case ChatStateSuccess(
                rejection: final rejection,
                isSuccess: final isSuccess
              )) {
            if (rejection != null) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(rejection.message)));
            } else if (isSuccess) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeOutExpo,
                );
              });
            }
          }
        },
        builder: (context, state) {
          return BlocBuilder<AuthBloc, AuthState>(
            bloc: widget.authBloc,
            builder: (context, authState) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    switch (state) {
                      ChatStateSuccess(chat: final chat) => chat.subject,
                      _ => '',
                    },
                  ),
                  actions: [
                    switch (authState) {
                      AuthStateAuthenticated(
                        authentication: final authentication
                      ) =>
                        authentication.userType == UserType.Imam
                            ? IconButton(
                                icon: const Icon(Icons.rotate_left_rounded),
                                tooltip: 'Вернуть в новые',
                                onPressed: () {
                                  context
                                      .read<ChatBloc>()
                                      .add(const ChatEventReturnToUnaswered());

                                  Modular.to.pop();
                                },
                              )
                            : Container(),
                      _ => Container(),
                    }
                  ],
                ),
                body: switch (state) {
                  ChatStateSuccess(
                    chat: final chat,
                    isInProgress: final isInProgress
                  ) =>
                    Column(
                      children: [
                        Expanded(
                          child: InProgressWidget(
                            isInProgress: isInProgress,
                            child: _list(
                              chat.messages ?? [],
                              context,
                              chat,
                              authState,
                            ),
                          ),
                        ),
                        switch (authState) {
                          AuthStateAuthenticated(authentication: final auth) =>
                            auth.userId == chat.askedBy ||
                                    auth.userType == UserType.Imam
                                ? MessageComposer(auth, widget.soundRecorder)
                                : Container(),
                          _ => Container(),
                        },
                      ],
                    ),
                  ChatStateInProgress() => InProgressWidget(child: Container()),
                  ChatStateError(rejection: final rejection) => RejectionWidget(
                      rejection: rejection,
                      onRefresh: () => context
                          .read<ChatBloc>()
                          .add(ChatEventRefresh(widget.id)),
                    ),
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _list(
    List<Message> items,
    BuildContext context,
    Chat chat,
    AuthState authState,
  ) {
    return RefreshIndicator.adaptive(
      onRefresh: () async =>
          context.read<ChatBloc>().add(ChatEventRefresh(widget.id)),
      child: ListView.separated(
        controller: _scrollController,
        itemCount: items.length,
        separatorBuilder: (_, __) =>
            const SizedBox(height: _messagePadding * 2),
        itemBuilder: (_, i) {
          final item = items[i];

          return Dismissible(
            key: ValueKey(item.id),
            confirmDismiss: (_) => Future.value(
              switch (authState) {
                AuthStateAuthenticated(authentication: final auth) =>
                  auth.userId == chat.askedBy || auth.userType == UserType.Imam,
                _ => false,
              },
            ),
            background: Container(color: warningColor),
            onDismissed: (_) =>
                context.read<ChatBloc>().add(ChatEventDeleteMessage(item.id)),
            child: MessageCard(
              item,
              authState,
              isItMine: switch (authState) {
                AuthStateAuthenticated(authentication: final auth) =>
                  auth.userId == chat.askedBy,
                _ => false,
              },
            ),
          );
        },
        key: const PageStorageKey('chat'),
        padding: const EdgeInsets.all(_messagePadding),
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
      ),
    );
  }
}
