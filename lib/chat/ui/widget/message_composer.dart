import 'package:askimam/chat/bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageComposer extends StatefulWidget {
  const MessageComposer({
    Key? key,
  }) : super(key: key);

  @override
  _MessageComposerState createState() => _MessageComposerState();
}

class _MessageComposerState extends State<MessageComposer> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Введите сообщение'),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: () {
            final text = _controller.text.trim();

            if (text.isNotEmpty) {
              context.read<ChatBloc>().add(ChatEvent.addText(text));
            }
          },
        ),
      ],
    );
  }
}
