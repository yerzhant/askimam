import 'dart:math';

import 'package:askimam/auto_direction.dart';
import 'package:askimam/chat.dart';
import 'package:askimam/consts.dart';
import 'package:askimam/delete_topics.dart';
import 'package:askimam/imam_main_public.dart';
import 'package:askimam/imams_rating.dart';
import 'package:askimam/localization.dart';
import 'package:askimam/questions_of_imam.dart';
import 'package:askimam/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ImamMainPage extends StatefulWidget {
  final User _user;
  final String _fcmToken;

  ImamMainPage(this._user, this._fcmToken);

  @override
  State createState() => _ImamMainPageState();
}

class _ImamMainPageState extends State<ImamMainPage> {
  final _random = Random();

  @override
  Widget build(BuildContext context) {
    final imageIdx = _random.nextInt(4);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(topicsCollection)
              .where('imamUid', isEqualTo: widget._user.uid)
              .snapshots(),
          initialData: null,
          builder: (_, snapshot) {
            if (snapshot.data == null || !snapshot.hasData) return Container();

            final hasNew = _isNewMessageForMe(snapshot);
            return AppBar(
              title: Text(AppLocalizations.of(context).newQuestions),
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
              title: Text(AppLocalizations.of(context).publicQuestions),
              leading: Icon(
                Icons.public,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ImamMainPagePublic(widget._user, widget._fcmToken),
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
            // ListTile(
            //   title: Text(
            //     'Поддержать проекты',
            //     style: TextStyle(color: Colors.white),
            //   ),
            //   tileColor: Theme.of(context).primaryColor,
            //   leading: Icon(
            //     Icons.support,
            //     color: Colors.blue[100],
            //   ),
            //   onTap: () {
            //     Navigator.pop(context);
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (_) => SponsorPage(),
            //       ),
            //     );
            //   },
            // ),
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
    return snapshot.data.docs.any((topic) =>
        topic['imamViewedOn'] != null &&
        topic['modifiedOn'] > topic['imamViewedOn']);
  }
}

class _Topics extends StatefulWidget {
  final User _user;
  final String _fcmToken;

  _Topics(this._user, this._fcmToken);

  @override
  _TopicsState createState() => _TopicsState();
}

class _TopicsState extends State<_Topics> {
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
          final hasNewMessages = topic.data()['imamViewedOn'] != null
              ? topic['modifiedOn'] > topic['imamViewedOn']
              : true;
          final isPublic =
              topic.data().containsKey('isPublic') && topic['isPublic'];

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
                    topic.id,
                    true,
                  ),
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

    Query query = FirebaseFirestore.instance
        .collection(topicsCollection)
        .where('imamUid', isNull: true)
        .orderBy('modifiedOn', descending: true)
        .limit(topicsChunkSize);

    if (_topics.length > 0) query = query.startAfterDocument(_topics.last);

    final snap = await query.get();
    _topics.addAll(snap.docs);
    _isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }
}
