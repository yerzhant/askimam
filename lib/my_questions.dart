import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:askimam/consts.dart';
import 'package:askimam/chat.dart';
import 'package:askimam/delete_topics.dart';
import 'package:askimam/localization.dart';
import 'package:askimam/auto_direction.dart';

class MyQuestionsPage extends StatelessWidget {
  final FirebaseUser _user;
  final String _fcmToken;

  MyQuestionsPage(this._user, this._fcmToken);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).myQuestions),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            tooltip: MaterialLocalizations.of(context).deleteButtonTooltip,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DeleteTopics(_user)),
              );
            },
          ),
        ],
      ),
      body: _Topics(_user, _fcmToken),
    );
  }
}

class _Topics extends StatefulWidget {
  final FirebaseUser _user;
  final String _fcmToken;

  _Topics(this._user, this._fcmToken);

  @override
  __TopicsState createState() => __TopicsState();
}

class __TopicsState extends State<_Topics> {
  final _topics = <DocumentSnapshot>[];
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final scrollThreshold = MediaQuery.of(context).size.height * .25;

      if (_scrollController.position.maxScrollExtent -
              _scrollController.position.pixels <
          scrollThreshold) _moreTopics();
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
      itemCount: _topics.length,
      separatorBuilder: (_, __) => Divider(),
      itemBuilder: (_, index) {
        final topic = _topics[index];
        final hasNewMessages = topic['modifiedOn'] > topic['viewedOn'];
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
                ),
              ),
            );
          },
          onLongPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DeleteTopics(widget._user, topic.documentID),
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
        .where('uid', isEqualTo: widget._user.uid)
        .orderBy('modifiedOn', descending: true)
        .limit(topicsChunkSize);

    if (_topics.length > 0) query = query.startAfterDocument(_topics.last);

    final snap = await query.getDocuments();
    setState(() {
      _topics.addAll(snap.documents);
    });
  }
}
