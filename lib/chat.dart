import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';

import 'package:askimam/composer.dart';
import 'package:askimam/consts.dart';
import 'package:askimam/localization.dart';
import 'package:askimam/audio_player.dart';
import 'package:askimam/auto_direction.dart';

enum _Action { share, edit, delete }

class Chat extends StatefulWidget {
  final FirebaseUser user;
  final DocumentSnapshot topic;
  final bool isImam;
  final String fcmToken;
  final bool isPublic;

  Chat({
    this.user,
    this.topic,
    this.fcmToken,
    this.isImam = false,
    this.isPublic = false,
  });

  @override
  State createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _random = Random();

  @override
  Widget build(BuildContext context) {
    final imageIdx = _random.nextInt(4);

    return WillPopScope(
      onWillPop: () async {
        currentlyPlaying?.stop();

        final now = DateTime.now().millisecondsSinceEpoch;
        final viewedField = {
          (widget.isImam ? 'imamViewedOn' : 'viewedOn'): now
        };
        final isMine = widget.topic['uid'] == widget.user.uid;
        if (isMine || widget.isImam) {
          widget.topic.reference.setData(viewedField, merge: true);
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: AutoDirection(
            text: widget.topic['name'],
            child: SizedBox(
              width: double.infinity,
              child: Text(widget.topic['name']),
            ),
          ),
          actions: _getActions(context),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/masjid-$imageIdx.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(.3),
                      BlendMode.dstATop,
                    ),
                  ),
                ),
                child: _buildList(context),
              ),
            ),
            // if (!widget.isPublic) Divider(height: 1),
            if (!widget.isPublic)
              Composer(
                user: widget.user,
                topic: widget.topic,
                fcmToken: widget.fcmToken,
                isImam: widget.isImam,
              ),
          ],
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot> _buildList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection(messagesCollection)
          .where('topicId', isEqualTo: widget.topic.documentID)
          .orderBy('createdOn', descending: true)
          .snapshots(),
      initialData: null,
      builder: (_, snapshot) {
        if (snapshot.data == null || !snapshot.hasData) return Container();

        final documents = snapshot.data.documents;

        return ListView.builder(
          reverse: true,
          padding: EdgeInsets.all(15),
          itemCount: documents.length,
          itemBuilder: (_, index) {
            return _buildMessage(context, documents[index]);
          },
        );
      },
    );
  }

  Widget _buildMessage(BuildContext context, DocumentSnapshot message) {
    final isImamsMessage = message['sender'] == 'i';
    final isMyMessage =
        !widget.isImam && !isImamsMessage || widget.isImam && isImamsMessage;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildImamName(context, message),
          message.data.containsKey('audioUrl')
              ? AudioPlayer(key: UniqueKey(), data: message.data)
              : Padding(
                  padding: EdgeInsets.only(
                    top: isImamsMessage ? 7 : 0,
                    bottom: 5,
                  ),
                  child: AutoDirection(
                    text: message['text'],
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        message['text'],
                        style: TextStyle(height: 1.5),
                      ),
                    ),
                  ),
                ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  _formatCreatedOn(message),
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              if (!widget.isPublic) _buildActionsMenu(message),
            ],
          ),
        ],
      ),
      margin: EdgeInsets.only(
        right: isMyMessage ? 0 : 40,
        left: isMyMessage ? 40 : 0,
        top: 10,
      ),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: isImamsMessage ? Colors.blue[50] : Colors.lightGreen[50],
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(150, 0, 0, 0),
              offset: Offset(0, 1),
              blurRadius: 3,
            )
          ]),
    );
  }

  String _formatCreatedOn(DocumentSnapshot message) {
    return DateFormat('d.MM.yyyy HH:mm:ss').format(
      DateTime.fromMillisecondsSinceEpoch(message['createdOn']),
    );
  }

  Widget _buildImamName(BuildContext context, DocumentSnapshot message) {
    if (message['sender'] == 'i' && message.data.containsKey('senderName')) {
      return Text(
        message['senderName'],
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      );
    } else {
      return Container();
    }
  }

  _buildActionsMenu(DocumentSnapshot message) {
    return PopupMenuButton<_Action>(
      child: Icon(Icons.more_vert, size: 16),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<_Action>>[
        PopupMenuItem(
          child: Text('Поделиться'),
          value: _Action.share,
        ),
        if (!message.data.containsKey('audioUrl'))
          PopupMenuItem(
            child: Text('Изменить'),
            value: _Action.edit,
          ),
        PopupMenuItem(
          child: Text('Удалить'),
          value: _Action.delete,
        ),
      ],
      onSelected: (action) {
        switch (action) {
          case _Action.share:
            var text = message['text'];
            text += _getAudioUrl(message);
            Share.share(text);
            break;

          case _Action.edit:
            break;

          case _Action.delete:
            Firestore.instance
                .collection(messagesCollection)
                .document(message.documentID)
                .delete();
            break;

          default:
        }
      },
    );
  }

  List<Widget> _getActions(BuildContext context) {
    if (widget.isImam) {
      return <Widget>[
        IconButton(
          icon: Icon(Icons.share),
          tooltip: AppLocalizations.of(context).share,
          onPressed: () {
            _share(context);
          },
        ),
        IconButton(
          icon: Icon(Icons.keyboard_return),
          tooltip: AppLocalizations.of(context).returnToNewQuestions,
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  content: Text(
                      AppLocalizations.of(context).returnToListOfNewQuestions),
                  actions: <Widget>[
                    FlatButton(
                      child:
                          Text(MaterialLocalizations.of(context).okButtonLabel),
                      onPressed: () {
                        final createdOn = DateTime.now().millisecondsSinceEpoch;
                        widget.topic.reference.setData({
                          'modifiedOn': createdOn,
                          'imamUid': null,
                        }, merge: true);
                        Navigator.of(context)..pop()..pop();
                      },
                    ),
                    FlatButton(
                      child: Text(
                          MaterialLocalizations.of(context).cancelButtonLabel),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              },
            );
          },
        ),
      ];
    } else {
      return <Widget>[
        IconButton(
          icon: Icon(Icons.share),
          tooltip: AppLocalizations.of(context).share,
          onPressed: () {
            _share(context);
          },
        ),
      ];
    }
  }

  void _share(BuildContext context) async {
    var text = AppLocalizations.of(context).subject +
        ': ' +
        widget.topic['name'] +
        '\n';

    var snap = await Firestore.instance
        .collection(messagesCollection)
        .where('topicId', isEqualTo: widget.topic.documentID)
        .orderBy('createdOn', descending: true)
        .getDocuments();

    snap.documents.sort((m1, m2) => m1['createdOn'] - m2['createdOn']);
    snap.documents.forEach((m) {
      text += '\n';
      if (m.data.containsKey('senderName') && m['senderName'] != null) {
        text += m['senderName'] + ':\n';
      } else if (m['sender'] == 'i') {
        text += AppLocalizations.of(context).teacher + ':\n';
      }
      text += m['text'];
      text += _getAudioUrl(m);
      text += '\n' + _formatCreatedOn(m) + '\n';
    });

    Share.share(text);
  }

  String _getAudioUrl(DocumentSnapshot m) {
    if (m.data.containsKey('audioUrl')) {
      var text =
          ' (если автоматически не открывается плеер, то при загрузке файла нужно установить ему расширение mp3):\n';
      text += m['audioUrl'];
      return text;
    }
    return '';
  }
}
