import 'dart:math';

import 'package:askimam/imam_main.dart';
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
import 'package:askimam/auto_direction.dart';

class ImamMainPagePublic extends StatefulWidget {
  final FirebaseUser _user;
  final String _fcmToken;

  ImamMainPagePublic(this._user, this._fcmToken);

  @override
  State createState() => _ImamMainPagePublicState();
}

class _ImamMainPagePublicState extends State<ImamMainPagePublic> {
  final _random = Random();

  @override
  Widget build(BuildContext context) {
    final imageIdx = _random.nextInt(4);

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
              title: Text(AppLocalizations.of(context).publicQuestions),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    hasNew ? Icons.announcement : Icons.list,
                    color: hasNew ? Colors.orange : null,
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
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  shadows: [Shadow(blurRadius: 5)],
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/masjid-$imageIdx.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).newQuestions),
              leading: Icon(
                Icons.new_releases,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ImamMainPage(widget._user, widget._fcmToken),
                  ),
                );
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).myMessages),
              leading: Icon(
                Icons.list,
                color: Theme.of(context).primaryColor,
              ),
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
              leading: Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
              ),
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
              leading: Icon(
                Icons.delete,
                color: Theme.of(context).primaryColor,
              ),
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
              leading: Icon(
                Icons.assessment,
                color: Theme.of(context).primaryColor,
              ),
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
              leading: Icon(
                Icons.public,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () async {
                Navigator.pop(context);
                await launch('https://azan.kz');
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).confidentialityPolicy),
              leading: Icon(
                Icons.info,
                color: Theme.of(context).primaryColor,
              ),
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
}

class _Topics extends StatefulWidget {
  final FirebaseUser _user;
  final String _fcmToken;

  _Topics(this._user, this._fcmToken);

  @override
  _TopicsState createState() => _TopicsState();
}

class _TopicsState extends State<_Topics> {
  final _topics = <DocumentSnapshot>[];
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) _moreTopics();
    });

    _moreTopics();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: _scrollController,
      itemCount: _topics.length,
      separatorBuilder: (_, __) => Divider(),
      itemBuilder: (_, index) {
        final topic = _topics[index];
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
              ? Icon(
                  Icons.public,
                  color: Theme.of(context).primaryColor,
                )
              : null,
          trailing:
              hasNewMessages ? Icon(Icons.chat, color: Colors.orange) : null,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Chat(
                  user: widget._user,
                  topic: topic,
                  fcmToken: widget._fcmToken,
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
                  widget._user,
                  topic.documentID,
                  true,
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _moreTopics() async {
    Query query = Firestore.instance
        .collection(topicsCollection)
        .where('isPublic', isEqualTo: true)
        .where('isAnswered', isEqualTo: true)
        .orderBy('modifiedOn', descending: true)
        .limit(topicsChunkSize);

    if (_topics.length > 0) query = query.startAfterDocument(_topics.last);

    final snap = await query.getDocuments();
    setState(() {
      _topics.addAll(snap.documents);
    });
  }
}
