import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:askimam/consts.dart';
import 'package:askimam/localization.dart';

class ImamsRating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).imamsRating),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: _buildList()),
          Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: _buildImams('ru-imams'),
                ),
                _buildImams('kz-imams'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImams(String key) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(settingsCollection)
          .where('key', isEqualTo: key)
          .snapshots(),
      builder: (_, snapshot) {
        if (snapshot.data == null || !snapshot.hasData) return Container();
        return Text(snapshot.data.documents[0]['value']);
      },
    );
  }

  Widget _buildList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(usersCollection)
          .orderBy('answered', descending: true)
          .snapshots(),
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.data == null || !snapshot.hasData) return Container();

        final documents = snapshot.data.docs;

        return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (_, index) => _buildItem(documents[index]),
        );
      },
    );
  }

  Widget _buildItem(DocumentSnapshot doc) {
    return ListTile(
      title: Text(doc['checkText']),
      trailing: Text(doc['answered'].toString()),
    );
  }
}
