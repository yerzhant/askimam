import 'package:askimam/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const _informativeMesssage =
    'Если Вы желаете, чтобы Ваши вопросы/переписка были перенесены на сервер azan.kz, то введите, пожалйуста, Ваш логин, который Вы используете для входа на сайт https://azan.kz.';

class ProfilePage extends StatefulWidget {
  final User _user;

  const ProfilePage(this._user, {Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _login = TextEditingController();

  var _isSaving = false;

  @override
  void initState() {
    super.initState();
    _getLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _informativeMesssage,
              style: TextStyle(height: 1.7),
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Логин',
                hintText: 'Логин для входа на сайт azan.kz',
              ),
              keyboardType: TextInputType.emailAddress,
              controller: _login,
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Builder(
                builder: (context) => ElevatedButton.icon(
                  onPressed: () async {
                    setState(() {
                      _isSaving = true;
                    });

                    await FirebaseFirestore.instance
                        .collection(profilesCollection)
                        .doc(widget._user.uid)
                        .set({'login': _login.text});

                    setState(() {
                      _isSaving = false;
                    });

                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Логин сохранён.'),
                      behavior: SnackBarBehavior.floating,
                    ));
                  },
                  icon: _isSaving
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Icon(Icons.save),
                  label: Text('СОХРАНИТЬ'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _getLogin() async {
    try {
      final profile = await FirebaseFirestore.instance
          .collection(profilesCollection)
          .doc(widget._user.uid)
          .get();

      setState(() {
        _login.text = profile['login'];
      });
    } catch (e) {}
  }
}
