import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:askimam/consts.dart';
import 'package:askimam/user/my_questions.dart';
import 'package:askimam/l10n/localization.dart';
import 'package:askimam/components/auto_direction.dart';

class NewQuestionPage extends StatefulWidget {
  final User _user;
  final String _fcmToken;

  NewQuestionPage(this._user, this._fcmToken);

  @override
  State createState() => _NewQuestionPageState();
}

enum _Visibility { private, public }

class _NewQuestionPageState extends State<NewQuestionPage> {
  final _formKey = GlobalKey<FormState>();
  var _visibility = _Visibility.private;
  String _topic = '';
  String _question = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).askQuestion),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              AutoDirection(
                text: _topic,
                child: TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).subject,
                    hintText: AppLocalizations.of(context).enterSubject,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return AppLocalizations.of(context).pleaseEnterSubject;
                    } else {
                      return null;
                    }
                  },
                  // onSaved: (topic) {
                  //   _topic = topic;
                  // },
                  onChanged: (value) {
                    setState(() {
                      _topic = value;
                    });
                  },
                ),
              ),
              RadioListTile<_Visibility>(
                  title: Text(AppLocalizations.of(context).privateQuestion),
                  value: _Visibility.private,
                  groupValue: _visibility,
                  onChanged: (value) {
                    setState(() {
                      _visibility = value;
                    });
                  }),
              RadioListTile<_Visibility>(
                  title: Text(AppLocalizations.of(context).publicQuestion),
                  value: _Visibility.public,
                  groupValue: _visibility,
                  onChanged: (value) {
                    setState(() {
                      _visibility = value;
                    });
                  }),
              SizedBox(
                height: 200,
                child: AutoDirection(
                  text: _question,
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context).enterQuestion,
                    ),
                    maxLines: 100,
                    validator: (value) {
                      if (value.isEmpty) {
                        return AppLocalizations.of(context).pleaseEnterQuestion;
                      } else {
                        return null;
                      }
                    },
                    // onSaved: (question) {
                    //   _question = question;
                    // },
                    onChanged: (value) {
                      setState(() {
                        _question = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: Text(AppLocalizations.of(context).send),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      final isImamRegistration =
                          _topic.toLowerCase().trim() == 'регистрация';

                      if (isImamRegistration) {
                        _registerImam(context);
                      } else {
                        _createQuestion();
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MyQuestionsPage(
                              widget._user,
                              widget._fcmToken,
                            ),
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createQuestion() async {
    final createdOn = DateTime.now().millisecondsSinceEpoch;

    final topic = FirebaseFirestore.instance.collection(topicsCollection).doc();

    await topic.set({
      'uid': widget._user.uid,
      'fcmToken': widget._fcmToken,
      'createdOn': createdOn,
      'modifiedOn': createdOn,
      'viewedOn': createdOn,
      'name': _topic,
      'imamUid': null,
      'imamFcmToken': null,
      'isPublic': _visibility == _Visibility.public,
    });

    FirebaseFirestore.instance.collection(messagesCollection).add({
      'uid': widget._user.uid,
      'createdOn': createdOn,
      'topicId': topic.id,
      'sender': 'q', // Questioner
      'text': _question,
    });
  }

  void _registerImam(BuildContext context) async {
    if (_question.toLowerCase().trim() != 'восстановление') {
      await FirebaseFirestore.instance
          .collection(usersCollection)
          .doc(widget._user.uid)
          .set({
        'checkText': _question,
        'role': 'reg-request',
      });
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isImam', true);

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return AlertDialog(
          content:
              Text(AppLocalizations.of(context).imamRegistrationConfirmation),
          actions: <Widget>[
            FlatButton(
              child: Text(MaterialLocalizations.of(context).okButtonLabel),
              onPressed: () {
                Navigator.of(context)..pop()..pop();
              },
            ),
          ],
        );
      },
    );
  }
}
