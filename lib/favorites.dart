import 'package:askimam/chat.dart';
import 'package:askimam/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  final FirebaseUser _user;
  final String _fcmToken;

  Favorites(this._user, this._fcmToken);

  @override
  State createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Избранные'),
      ),
      body: _buildTopics(),
    );
  }

  Widget _buildTopics() {
    final stream = Firestore.instance
        .collection(favoritesCollection)
        .where('uid', isEqualTo: widget._user.uid)
        .orderBy('createdOn', descending: true)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.data == null || !snapshot.hasData)
          return CircularProgressIndicator();

        final documents = snapshot.data.documents;

        return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (_, index) => _buildTopic(documents[index]),
        );
      },
    );
  }

  Widget _buildTopic(DocumentSnapshot doc) {
    return Dismissible(
      key: Key(doc.documentID),
      background: Container(color: Colors.red[100]),
      child: ListTile(
        title: Text(doc['topicName']),
        onTap: () async {
          final topic = await Firestore.instance
              .collection(topicsCollection)
              .document(doc['topicId'])
              .snapshots()
              .first;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Chat(
                user: widget._user,
                topic: topic,
                fcmToken: widget._fcmToken,
                isPublic: true,
              ),
            ),
          );
        },
      ),
      onDismissed: (direction) => _deleteFavorite(doc),
    );
  }

  void _deleteFavorite(DocumentSnapshot doc) {
    Firestore.instance
        .collection(favoritesCollection)
        .document(doc.documentID)
        .delete();

    Provider.of<FavoriteState>(context, listen: false)
        .removeTopicId(doc['topicId']);
  }
}

class FavoriteState extends ChangeNotifier {
  final FirebaseUser user;
  final favoriteTopicIds = <String>[];

  FavoriteState(this.user) {
    refresh();
  }

  void addTopicId(String id) {
    favoriteTopicIds.add(id);
    notifyListeners();
  }

  void removeTopicId(String id) {
    favoriteTopicIds.remove(id);
    notifyListeners();
  }

  Future<void> refresh() async {
    final snap = await Firestore.instance
        .collection(favoritesCollection)
        .where('uid', isEqualTo: user.uid)
        .getDocuments();

    final ids =
        snap.documents.map((e) => e.data['topicId']).toList().cast<String>();
    favoriteTopicIds.clear();
    favoriteTopicIds.addAll(ids);

    notifyListeners();
  }
}
