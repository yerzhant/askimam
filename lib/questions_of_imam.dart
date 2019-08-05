import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:askimam/chat.dart';
import 'package:askimam/delete_topics.dart';
import 'package:askimam/consts.dart';
import 'package:askimam/localization.dart';

class QuestionsOfImamPage extends StatelessWidget {
  final FirebaseUser _user;

  QuestionsOfImamPage(this._user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).myMessages),
      ),
      body: _Topics(_user),
    );
  }
}

class _Topics extends StatelessWidget {
  final FirebaseUser _user;

  _Topics(this._user);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection(topicsCollection)
          .where('imamUid', isEqualTo: _user.uid)
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
            var hasNewMessages = true;
            if (topic.data.containsKey('imamViewedOn')) {
              hasNewMessages = topic['modifiedOn'] > topic['imamViewedOn'];
            }
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
