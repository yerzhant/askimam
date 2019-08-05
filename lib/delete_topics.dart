import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:askimam/consts.dart';

class DeleteTopics extends StatefulWidget {
  final FirebaseUser _user;
  final String _topicId;
  final bool _isImam;

  DeleteTopics(this._user, [this._topicId, this._isImam = false]);

  @override
  State createState() => _DeleteTopicsState(_topicId);
}

class _DeleteTopicsState extends State<DeleteTopics> {
  final _selected = Set<String>();

  _DeleteTopicsState(String topicId) {
    if (topicId != null) _selected.add(topicId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MaterialLocalizations.of(context).deleteButtonTooltip),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              for (var topicId in _selected) {
                _deleteTopic(topicId);
              }
              _selected.clear();
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: _buildTopics(),
    );
  }

  void _deleteTopic(String topicId) async {
    Firestore.instance.collection(topicsCollection).document(topicId).delete();

    final messagesSnapshot = await Firestore.instance
        .collection(messagesCollection)
        .where('topicId', isEqualTo: topicId)
        .snapshots()
        .first;

    messagesSnapshot.documents.forEach((doc) => doc.reference.delete());
  }

  Widget _buildTopics() {
    final CollectionReference collectionReference =
        Firestore.instance.collection(topicsCollection);
    final Query query = widget._isImam
        ? collectionReference
        : collectionReference.where('uid', isEqualTo: widget._user.uid);

    return StreamBuilder<QuerySnapshot>(
      stream: query.orderBy('modifiedOn', descending: true).snapshots(),
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.data == null || !snapshot.hasData) return Container();

        final documents = snapshot.data.documents;

        return ListView.separated(
          itemCount: documents.length,
          separatorBuilder: (_, __) => Divider(height: 1),
          itemBuilder: (_, index) => _buildTopic(documents[index]),
        );
      },
    );
  }

  Widget _buildTopic(DocumentSnapshot doc) {
    final selected = _selected.contains(doc.documentID);

    return ListTile(
      title: Text(doc['name']),
      selected: selected,
      trailing: Icon(
        selected ? Icons.check_circle : null,
        color: Colors.red,
      ),
      onTap: () {
        setState(() {
          if (selected) {
            _selected.remove(doc.documentID);
          } else {
            _selected.add(doc.documentID);
          }
        });
      },
    );
  }
}
