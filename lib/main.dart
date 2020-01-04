import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:askimam/consts.dart';
import 'package:askimam/new_question.dart';
import 'package:askimam/my_questions.dart';
import 'package:askimam/chat.dart';
import 'package:askimam/imam_main.dart';
import 'package:askimam/delete_topics.dart';
import 'package:askimam/imams_rating.dart';
import 'package:askimam/search.dart';
import 'package:askimam/localization.dart';
import 'package:askimam/auto_direction.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
FirebaseUser _user;
bool _isImam = false;
String _fcmToken;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(AskImamApp());
}

class AskImamApp extends StatelessWidget {
  AskImamApp() {
    _signIn();

    _firebaseMessaging.getToken().then((token) {
      _fcmToken = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context).appName,
      home: _firstPage(),
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('ru', ''),
        const Locale('kk', ''),
      ],
      // debugShowCheckedModeBanner: false,
    );
  }
}

void _signIn() async {
  final prefs = await SharedPreferences.getInstance();
  _isImam = prefs.getBool('isImam') ?? false;
  // _isImam = true;

  if (_isImam) {
    _firebaseMessaging.subscribeToTopic(imamsTopic);
  }

  final _googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;

  final googleUser = await _googleSignIn.signIn();
  final googleAuth = await googleUser.authentication;

  final credential = GoogleAuthProvider.getCredential(
    idToken: googleAuth.idToken,
    accessToken: googleAuth.accessToken,
  );

  await _auth.signInWithCredential(credential);
}

Widget _firstPage() {
  return StreamBuilder<FirebaseUser>(
    stream: FirebaseAuth.instance.onAuthStateChanged,
    initialData: null,
    builder: (context, snapshot) {
      if (snapshot.data != null &&
          snapshot.connectionState == ConnectionState.active &&
          snapshot.hasData) {
        _user = snapshot.data;
        return _isImam ? ImamMainPage(_user, _fcmToken) : _MainPage();
      } else {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/masjid-1.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(.5),
                BlendMode.dstATop,
              ),
            ),
          ),
          child: Center(
            child: Text(
              AppLocalizations.of(context).enteringIntoSystem,
              style: TextStyle(
                inherit: false,
                color: Colors.blue[200],
                fontSize: 16,
              ),
            ),
          ),
        );
      }
    },
  );
}

class _MainPage extends StatelessWidget {
  final _random = Random();

  bool _isNewMessageForMe(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .any((topic) => topic['modifiedOn'] > topic['viewedOn']);
  }

  @override
  Widget build(BuildContext context) {
    final imageIdx = _random.nextInt(4);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection(topicsCollection)
              .where('uid', isEqualTo: _user.uid)
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
                  tooltip: AppLocalizations.of(context).myQuestions,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MyQuestionsPage(_user, _fcmToken),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
      body: _Topics(),
      floatingActionButton: _buildNewQuestionButton(context),
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
              title: Text(AppLocalizations.of(context).askQuestion),
              leading: Icon(
                Icons.add,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NewQuestionPage(_user, _fcmToken),
                  ),
                );
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).myQuestions),
              leading: Icon(
                Icons.list,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MyQuestionsPage(_user, _fcmToken),
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
                    builder: (_) => Search(user: _user, fcmToken: _fcmToken),
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
                    builder: (_) => DeleteTopics(_user),
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

  Widget _buildNewQuestionButton(BuildContext context) {
    if (!_isImam) {
      return FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: AppLocalizations.of(context).askQuestion,
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => NewQuestionPage(_user, _fcmToken)),
          );
        },
      );
    } else {
      return null;
    }
  }
}

class _Topics extends StatefulWidget {
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
      controller: _scrollController,
      itemCount: _topics.length,
      separatorBuilder: (_, __) => Divider(),
      itemBuilder: (_, index) {
        final topic = _topics[index];
        return ListTile(
          title: AutoDirection(
            text: topic['name'],
            child: Text(topic['name']),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Chat(
                  user: _user,
                  topic: topic,
                  fcmToken: _fcmToken,
                  isPublic: true,
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _moreTopics() async {
    var query = Firestore.instance
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
