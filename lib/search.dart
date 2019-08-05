import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:algolia/algolia.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:askimam/consts.dart';
import 'package:askimam/chat.dart';
import 'package:askimam/localization.dart';

final _algolia = Algolia.init(
    applicationId: "HKPC9P01WI", apiKey: "fbde107bf3464d149fa699cd0aea85e4");

class Search extends StatefulWidget {
  final FirebaseUser user;
  final bool isImam;
  final String fcmToken;

  Search({
    this.user,
    this.fcmToken,
    this.isImam = false,
  });

  @override
  State<StatefulWidget> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var _query = _algolia.instance
      .index(messagesIndex)
      .setAttributesToRetrieve(['topicName', 'topicId']);
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MaterialLocalizations.of(context).searchFieldLabel),
      ),
      body: Column(
        children: <Widget>[
          _buildMessageEditor(context),
          Divider(height: 1),
          Expanded(
            child: _buildList(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 130, vertical: 10),
            child: GestureDetector(
              child: Image.asset('images/algolia.png'),
              onTap: () async {
                await launch('https://www.algolia.com');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageEditor(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              autofocus: true,
              textInputAction: TextInputAction.search,
              onEditingComplete: _search,
              decoration: InputDecoration.collapsed(
                hintText: AppLocalizations.of(context).searchPrompt,
              ),
            ),
          ),
          IconButton(
            padding: const EdgeInsets.all(0),
            icon: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
            ),
            tooltip: AppLocalizations.of(context).sendMessage,
            onPressed: () {
              _search();
            },
          ),
        ],
      ),
    );
  }

  void _search() {
    setState(() {
      _query = _query.search(_controller.text);
    });
  }

  Widget _buildList() {
    if (_controller.text.isEmpty) return Container();

    return FutureBuilder<AlgoliaQuerySnapshot>(
      future: _query.getObjects(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else if (snapshot.hasData) {
          final List<AlgoliaObjectSnapshot> topics = [];
          snapshot.data.hits.forEach((doc) {
            if (!topics.any((t) => t.data['topicId'] == doc.data['topicId'])) {
              topics.add(doc);
            }
          });

          return ListView.separated(
            itemCount: topics.length,
            separatorBuilder: (_, __) => Divider(height: 1),
            itemBuilder: (_, index) => _buildItem(topics[index], context),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildItem(AlgoliaObjectSnapshot doc, BuildContext context) {
    return ListTile(
      title: Text(doc.data['topicName']),
      onTap: () {
        Firestore.instance
            .document(topicsCollection + '/' + doc.data['topicId'])
            .get()
            .then((snap) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Chat(
                    user: widget.user,
                    topic: snap,
                    fcmToken: widget.fcmToken,
                    isImam: widget.isImam,
                    isPublic: true,
                  ),
            ),
          );
        });
      },
    );
  }
}
