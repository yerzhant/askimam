import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/chat/bloc/chat_bloc.dart';
import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/chat/domain/model/message.dart';
import 'package:askimam/chat/ui/widget/message_card.dart';
import 'package:askimam/chat/ui/widget/message_composer.dart';
import 'package:askimam/common/ui/ui_constants.dart';
import 'package:askimam/common/ui/widget/in_progress_widget.dart';
import 'package:askimam/common/ui/widget/rejection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _interMessageSpace = 10.0;

const _horizontalPadding = 10.0;

class ChatPage extends StatelessWidget {
  final int id;
  final ChatBloc bloc;
  final AuthBloc authBloc;

  ChatPage(this.id, this.bloc, this.authBloc) {
    bloc.add(ChatEvent.refresh(id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocConsumer<ChatBloc, ChatState>(
        listenWhen: (_, current) => current.maybeWhen(
          (chat, rejection, isInProgress, isSuccess) => rejection != null,
          orElse: () => false,
        ),
        listener: (context, state) {
          state.maybeWhen(
            (chat, rejection, isInProgress, isSuccess) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(rejection!.reason)));
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return BlocBuilder<AuthBloc, AuthState>(
            bloc: authBloc,
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
                            onPressed: () => context
                                .read<ChatBloc>()
                                .add(const ChatEvent.returnToUnaswered()),
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
                    onRefresh: () =>
                        context.read<ChatBloc>().add(ChatEvent.refresh(id)),
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
          context.read<ChatBloc>().add(ChatEvent.refresh(id)),
      child: ListView.separated(
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
        padding: const EdgeInsets.symmetric(
          horizontal: _horizontalPadding,
          vertical: basePadding,
        ),
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
      ),
    );
  }
}
