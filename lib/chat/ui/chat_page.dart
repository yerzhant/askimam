import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/chat/bloc/chat_bloc.dart';
import 'package:askimam/chat/domain/model/message.dart';
import 'package:askimam/chat/ui/widget/message_composer.dart';
import 'package:askimam/common/ui/widget/in_progress_widget.dart';
import 'package:askimam/common/ui/widget/rejection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                          ),
                        ),
                      ),
                      const MessageComposer(),
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

  Widget _list(List<Message> items, BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async =>
          context.read<ChatBloc>().add(ChatEvent.refresh(id)),
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (_, i) {
          final item = items[i];

          return Dismissible(
            key: Key(item.id.toString()),
            onDismissed: (_) =>
                context.read<ChatBloc>().add(ChatEvent.deleteMessage(item.id)),
            child: ListTile(title: Text(item.text)),
          );
        },
        physics: const AlwaysScrollableScrollPhysics(),
      ),
    );
  }
}
