import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/common/ui/widget/wide_button.dart';
import 'package:flutter/material.dart';

class NewQuestionPage extends StatefulWidget {
  @override
  _NewQuestionPageState createState() => _NewQuestionPageState();
}

class _NewQuestionPageState extends State<NewQuestionPage> {
  var _type = ChatType.Private;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          RadioListTile<ChatType>(
            title: const Text('Приватный'),
            value: ChatType.Private,
            groupValue: _type,
            onChanged: (value) {
              setState(() {
                _type = value!;
              });
            },
          ),
          RadioListTile<ChatType>(
            title: const Text('Публичный'),
            value: ChatType.Public,
            groupValue: _type,
            onChanged: (value) {
              setState(() {
                _type = value!;
              });
            },
          ),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Тема',
              hintText: 'Введите тему',
              helperText: 'Не обязательное поле',
            ),
          ),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Вопрос',
              hintText: 'Введите вопрос',
            ),
          ),
          const WideButton('ОТПРАВИТЬ', Icons.send),
        ],
      ),
    );
  }
}
