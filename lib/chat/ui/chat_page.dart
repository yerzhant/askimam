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
import 'package:flutter_modular/flutter_modular.dart';

const _interMessageSpace = 10.0;

class ChatPage extends StatefulWidget {
  final int id;
  final ChatBloc bloc;
  final AuthBloc authBloc;

  ChatPage(this.id, this.bloc, this.authBloc) {
    bloc.add(ChatEvent.refresh(id));
  }

  @override
  _ChatPageState createState() => _ChatPageState();
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
          state.maybeWhen(
            (chat, rejection, isInProgress, isSuccess) {
              if (rejection != null) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(rejection.reason)));
              } else if (isSuccess) {
                SchedulerBinding.instance?.addPostFrameCallback((_) {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeOut,
                  );
                });
              }
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return BlocBuilder<AuthBloc, AuthState>(
            bloc: widget.authBloc,
            builder: (context, authState) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    state.maybeWhen(
                      (chat, rejection, isInProgress, isSuccess) =>
                          chat.subject,
                      orElse: () => '',
                    ),
                  ),
                  actions: [
                    authState.maybeWhen(
                      authenticated: (authentication) {
                        if (authentication.userType == UserType.Imam) {
                          return IconButton(
                            icon: const Icon(Icons.assignment_return),
                            tooltip: 'Вернуть в новые',
                            onPressed: () {
                              context
                                  .read<ChatBloc>()
                                  .add(const ChatEvent.returnToUnaswered());

                              Modular.to.pop();
                            },
                          );
                        } else {
                          return Container();
                        }
                      },
                      orElse: () => Container(),
                    ),
                  ],
                ),
                body: state.when(
                  (chat, rejection, isInProgress, isSuccess) => Column(
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
                      authState.maybeWhen(
                        authenticated: (auth) {
                          if (auth.userId == chat.askedBy ||
                              auth.userType == UserType.Imam) {
                            return const MessageComposer();
                          } else {
                            return Container();
                          }
                        },
                        orElse: () => Container(),
                      ),
                    ],
                  ),
                  inProgress: () => InProgressWidget(child: Container()),
                  error: (rejection) => RejectionWidget(
                    rejection: rejection,
                    onRefresh: () => context
                        .read<ChatBloc>()
                        .add(ChatEvent.refresh(widget.id)),
                  ),
                ),
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
    return RefreshIndicator(
      onRefresh: () async =>
          context.read<ChatBloc>().add(ChatEvent.refresh(widget.id)),
      child: ListView.separated(
        controller: _scrollController,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: _interMessageSpace),
        itemBuilder: (_, i) {
          final item = items[i];

          return Dismissible(
            key: ValueKey(item.id),
            confirmDismiss: (_) => Future.value(
              authState.maybeWhen(
                authenticated: (auth) {
                  if (auth.userId == chat.askedBy ||
                      auth.userType == UserType.Imam) {
                    return true;
                  } else {
                    return false;
                  }
                },
                orElse: () => false,
              ),
            ),
            background: Container(color: secondaryColor),
            onDismissed: (_) =>
                context.read<ChatBloc>().add(ChatEvent.deleteMessage(item.id)),
            child: MessageCard(
              item,
              authState,
              isItMine: authState.maybeWhen(
                authenticated: (auth) => auth.userId == chat.askedBy,
                orElse: () => false,
              ),
            ),
          );
        },
        key: const PageStorageKey('chat'),
        padding: const EdgeInsets.all(_interMessageSpace),
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
      ),
    );
  }
}
