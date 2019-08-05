import 'dart:math';

import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:askimam/consts.dart';
import 'package:askimam/questions_of_imam.dart';
import 'package:askimam/chat.dart';
import 'package:askimam/delete_topics.dart';
import 'package:askimam/imams_rating.dart';
import 'package:askimam/search.dart';
import 'package:askimam/localization.dart';

bool _isNewQuestions = true;

class ImamMainPage extends StatefulWidget {
  final FirebaseUser _user;
  final String _fcmToken;

  ImamMainPage(this._user, this._fcmToken);

  @override
  State createState() => _ImamMainPageState();
}

class _ImamMainPageState extends State<ImamMainPage> {
  final _random = Random();
  String title;
  String switchMenuTitle;
  Icon switchMenuIcon = Icon(Icons.public);

  void initTitles(BuildContext context) {
    if (title == null) {
      title = AppLocalizations.of(context).newQuestions;
      switchMenuTitle = AppLocalizations.of(context).publicQuestions;
    }
  }

  @override
  Widget build(BuildContext context) {
    initTitles(context);

    final imageIdx = _random.nextInt(4);
    Color appNameColor;
    switch (imageIdx) {
      case 2:
        appNameColor = Colors.orange[700];
        break;

      default:
        appNameColor = Colors.white;
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection(topicsCollection)
              .where('imamUid', isEqualTo: widget._user.uid)
              .snapshots(),
          initialData: null,
          builder: (_, snapshot) {
            if (snapshot.data == null || !snapshot.hasData) return Container();

            final hasNew = _isNewMessageForMe(snapshot);
            return AppBar(
              title: Text(title),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    hasNew ? Icons.announcement : Icons.list,
                    color: hasNew ? Colors.redAccent : null,
                  ),
                  tooltip: AppLocalizations.of(context).myMessages,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QuestionsOfImamPage(widget._user),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
      body: _Topics(widget._user, widget._fcmToken),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text(
                AppLocalizations.of(context).appName,
                style: TextStyle(color: appNameColor, fontSize: 16),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/masjid-$imageIdx.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              title: Text(switchMenuTitle),
              leading: switchMenuIcon,
              onTap: () {
                Navigator.pop(context);
                _switchQuestions(context);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).myMessages),
              leading: Icon(Icons.list),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuestionsOfImamPage(widget._user),
                  ),
                );
              },
            ),
            ListTile(
              title: Text(MaterialLocalizations.of(context).searchFieldLabel),
              leading: Icon(Icons.search),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Search(
                      user: widget._user,
                      fcmToken: widget._fcmToken,
                      isImam: true,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).deleteQuestions),
              leading: Icon(Icons.delete),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DeleteTopics(widget._user, null, true),
                  ),
                );
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).imamsRating),
              leading: Icon(Icons.assessment),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ImamsRating(),
                  ),
                );
              },
            ),
            Divider(height: 1),
            ListTile(
              title: Text('Azan.kz'),
              leading: Icon(Icons.public),
              onTap: () async {
                Navigator.pop(context);
                await launch('https://azan.kz');
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).confidentialityPolicy),
              leading: Icon(Icons.info),
              onTap: () async {
                Navigator.pop(context);
                await launch(policyUrl);
              },
            ),
          ],
        ),
      ),
    );
  }

  bool _isNewMessageForMe(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents.any((topic) =>
        topic['imamViewedOn'] != null &&
        topic['modifiedOn'] > topic['imamViewedOn']);
  }

  void _switchQuestions(BuildContext context) {
    setState(() {
      if (_isNewQuestions) {
        _isNewQuestions = false;
        title = AppLocalizations.of(context).publicQuestions;
        switchMenuTitle = AppLocalizations.of(context).newQuestions;
        switchMenuIcon = Icon(Icons.new_releases);
      } else {
        _isNewQuestions = true;
        title = AppLocalizations.of(context).newQuestions;
        switchMenuTitle = AppLocalizations.of(context).publicQuestions;
        switchMenuIcon = Icon(Icons.public);
      }
    });
  }
}

class _Topics extends StatelessWidget {
  final FirebaseUser _user;
  final String _fcmToken;

  _Topics(this._user, this._fcmToken);

  @override
  Widget build(BuildContext context) {
    Query topics;
    if (_isNewQuestions) {
      topics = Firestore.instance
          .collection(topicsCollection)
          .where('imamUid', isNull: true);
    } else {
      topics = Firestore.instance
          .collection(topicsCollection)
          .where('isPublic', isEqualTo: true)
          .where('isAnswered', isEqualTo: true);
    }

    return StreamBuilder<QuerySnapshot>(
      stream: topics.orderBy('modifiedOn', descending: true).snapshots(),
      initialData: null,
      builder: (_, snapshot) {
        if (snapshot.data == null || !snapshot.hasData) return Container();

        final documents = snapshot.data.documents;

        return ListView.separated(
          itemCount: documents.length,
          separatorBuilder: (_, __) => Divider(height: 1),
          itemBuilder: (_, index) {
            final topic = documents[index];
            final hasNewMessages = topic['imamViewedOn'] != null
                ? topic['modifiedOn'] > topic['imamViewedOn']
                : true;
            final isPublic =
                topic.data.containsKey('isPublic') && topic['isPublic'];

            return ListTile(
              selected: hasNewMessages,
              title: AutoDirection(
                text: topic['name'],
                child: Text(topic['name']),
              ),
              subtitle: hasNewMessages
                  ? Text(AppLocalizations.of(context).hasNewMessage)
                  : null,
              leading: isPublic
                  ? Icon(Icons.public, color: Colors.greenAccent[400])
                  : null,
              trailing: hasNewMessages
                  ? Icon(Icons.chat, color: Colors.orange)
                  : null,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Chat(
                      user: _user,
                      topic: topic,
                      fcmToken: _fcmToken,
                      isImam: true,
                    ),
                  ),
                );
              },
              onLongPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DeleteTopics(
                      _user,
                      topic.documentID,
                      true,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
