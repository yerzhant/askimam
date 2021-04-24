import 'package:askimam/chat/bloc/chat_bloc.dart';
import 'package:askimam/chat/domain/model/message.dart';
import 'package:askimam/common/ui/widget/in_progress_widget.dart';
import 'package:askimam/common/ui/widget/rejection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  final ChatBloc bloc;
  final int id;

  ChatPage(this.bloc, this.id) {
    bloc.add(ChatEvent.refresh(id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                state.maybeWhen(
                  (chat, rejection, isInProgress, isSuccess) => chat.subject,
                  orElse: () => '',
                ),
              ),
            ),
            body: state.when(
              (chat, rejection, isInProgress, isSuccess) => Column(
                children: [
                  Expanded(
                    child: _list(
                      chat.messages ?? [],
                      context,
                    ),
                  ),
                  _textEditor(context),
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

  Widget _textEditor(BuildContext context) => Row(
        children: [
          const Expanded(
            child: TextField(
              decoration: InputDecoration(hintText: 'Введите сообщение'),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {},
          ),
        ],
      );
}
