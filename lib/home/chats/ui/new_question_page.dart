import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/common/ui/ui_constants.dart';
import 'package:askimam/common/ui/widget/wide_button.dart';
import 'package:askimam/home/chats/bloc/my_chats_bloc.dart';
import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NewQuestionPage extends StatefulWidget {
  final MyChatsBloc _bloc;

  const NewQuestionPage(this._bloc, {Key? key}) : super(key: key);

  @override
  State createState() => _NewQuestionPageState();
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
      appBar: AppBar(title: const Text('Задать вопрос')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(basePadding),
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                RadioListTile<ChatType>.adaptive(
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  title: const Text('Приватный'),
                  value: ChatType.Private,
                  groupValue: _type,
                  onChanged: (value) => setState(() => _type = value!),
                ),
                RadioListTile<ChatType>.adaptive(
                  visualDensity: VisualDensity.compact,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Публичный'),
                  value: ChatType.Public,
                  groupValue: _type,
                  onChanged: (value) => setState(() => _type = value!),
                ),
                const SizedBox(height: interElementMargin),
                AutoDirection(
                  text: _subject.text,
                  child: TextFormField(
                    controller: _subject,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: 'Тема',
                      hintText: 'Необязательное поле',
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(height: interElementMargin),
                AutoDirection(
                  text: _text.text,
                  child: TextFormField(
                    controller: _text,
                    maxLines: 13,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: 'Вопрос',
                      hintText: 'Введите вопрос',
                      alignLabelWithHint: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите значение';
                      }
                      return null;
                    },
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(height: interElementMargin),
                WideButton('ОТПРАВИТЬ', () {
                  if (_formKey.currentState!.validate()) {
                    widget._bloc.add(MyChatsEventAdd(
                      _type,
                      _getSubject,
                      _text.text.trim(),
                    ));
                    Modular.to.pop();
                  }
                }),
              ],
            ),
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
