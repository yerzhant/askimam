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

class _Topics extends StatelessWidget {
  final FirebaseUser _user;
  final String _fcmToken;

  _Topics(this._user, this._fcmToken);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection(topicsCollection)
          .where('uid', isEqualTo: _user.uid)
          .orderBy('modifiedOn', descending: true)
          .snapshots(),
      initialData: null,
      builder: (_, snapshot) {
        if (snapshot.data == null || !snapshot.hasData) return Container();

        final documents = snapshot.data.documents;

        return ListView.separated(
          itemCount: documents.length,
          separatorBuilder: (_, __) => Divider(height: 1),
          itemBuilder: (_, index) {
            final topic = documents[index];
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
                    ),
                  ),
                );
              },
              onLongPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => DeleteTopics(_user, topic.documentID)),
                );
              },
            );
          },
        );
      },
    );
  }
}
