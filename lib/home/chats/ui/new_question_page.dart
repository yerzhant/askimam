import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/common/ui/widget/wide_button.dart';
import 'package:askimam/home/chats/bloc/my_chats_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NewQuestionPage extends StatefulWidget {
  final MyChatsBloc _bloc;

  const NewQuestionPage(this._bloc, {Key? key}) : super(key: key);

  @override
  _NewQuestionPageState createState() => _NewQuestionPageState();
}

class _NewQuestionPageState extends State<NewQuestionPage> {
  final _formKey = GlobalKey<FormState>();
  final _subject = TextEditingController();
  final _text = TextEditingController();

  var _type = ChatType.Private;

  @override
  void dispose() {
    _subject.dispose();
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
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
              TextFormField(
                controller: _subject,
                decoration: const InputDecoration(
                  labelText: 'Тема',
                  helperText: 'Не обязательное поле',
                ),
              ),
              TextFormField(
                controller: _text,
                decoration: const InputDecoration(
                  labelText: 'Вопрос',
                  hintText: 'Введите вопрос',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите значение';
                  }
                },
              ),
              WideButton('ОТПРАВИТЬ', Icons.send, () {
                if (_formKey.currentState!.validate()) {
                  widget._bloc.add(MyChatsEvent.add(
                    _type,
                    _getSubject,
                    _text.text.trim(),
                  ));
                  Modular.to.pop();
                  Modular.to.navigate('/my');
                  // Modular.to.popAndPushNamed('/my');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  String? get _getSubject {
    final text = _subject.text.trim();
    return text.isEmpty ? null : text;
  }
}
