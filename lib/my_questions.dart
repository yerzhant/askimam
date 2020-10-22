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
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _moreTopics();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (!_isLoading &&
        _scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) _moreTopics();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _topics.clear();
        await _moreTopics();
      },
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        itemCount: _topics.length + 1,
        itemBuilder: (_, index) {
          if (index == _topics.length) {
            return Center(
              child: Opacity(
                opacity: _topics.length > 0 && _isLoading ? 1 : 0,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
            );
          }

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
      ),
    );
  }

  Future<void> _moreTopics() async {
    setState(() {
      _isLoading = true;
    });

    Query query = Firestore.instance
        .collection(topicsCollection)
        .where('uid', isEqualTo: widget._user.uid)
        .orderBy('modifiedOn', descending: true)
        .limit(topicsChunkSize);

    if (_topics.length > 0) query = query.startAfterDocument(_topics.last);

    final snap = await query.getDocuments();
    _topics.addAll(snap.documents);
    _isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }
}
