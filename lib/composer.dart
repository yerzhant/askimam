import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sound/flutter_sound.dart';

import 'package:askimam/consts.dart';
import 'package:askimam/localization.dart';
import 'package:intl/intl.dart';
import 'package:askimam/auto_direction.dart';

const _initial_recording_time = '00:00';

class Composer extends StatefulWidget {
  final FirebaseUser user;
  final DocumentSnapshot topic;
  final String fcmToken;
  final bool isImam;

  Composer({this.user, this.topic, this.fcmToken, this.isImam = false});

  @override
  State<StatefulWidget> createState() => _Composer();
}

class _Composer extends State<Composer> {
  final _controller = TextEditingController();
  final _recorder = FlutterSound();
  String _senderName;
  int _composerIndex = 0;
  String _audioPath;
  String _recordingTime = _initial_recording_time;
  double _dBLevel = 0;
  StreamSubscription _soundRecordingSubscription;
  StreamSubscription _dBLevelSubscription;

  @override
  void initState() {
    super.initState();

    _recorder.setSubscriptionDuration(1);
    _recorder.setDbPeakLevelUpdate(.2);
    _recorder.setDbLevelEnabled(true);

    if (widget.isImam) {
      Firestore.instance
          .document(usersCollection + '/' + widget.user.uid)
          .get()
          .then((snap) {
        _senderName = snap['checkText'];
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _composerIndex,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 15),
          child: Row(
            children: <Widget>[
              Expanded(
                child: AutoDirection(
                  text: _controller.text,
                  child: TextField(
                    controller: _controller,
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration.collapsed(
                      hintText: AppLocalizations.of(context).enterMessage,
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.send,
                  color: Theme.of(context).primaryColor,
                ),
                tooltip: AppLocalizations.of(context).sendMessage,
                onPressed: () {
                  _sendText();
                },
              ),
              if (widget.isImam)
                IconButton(
                  icon: Icon(
                    Icons.mic,
                    color: Colors.greenAccent,
                  ),
                  tooltip: AppLocalizations.of(context).audioMessage,
                  onPressed: () {
                    _startRecording();
                  },
                ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: LinearProgressIndicator(
                  value: _dBLevel / 160,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                  backgroundColor: Colors.black12,
                ),
              ),
            ),
            Text(_recordingTime,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            IconButton(
              icon: Icon(
                Icons.cancel,
                color: Colors.red,
              ),
              tooltip: MaterialLocalizations.of(context).cancelButtonLabel,
              onPressed: () {
                _cancelRecording();
              },
            ),
            IconButton(
              icon: Icon(
                Icons.send,
                color: Theme.of(context).primaryColor,
              ),
              tooltip: AppLocalizations.of(context).sendMessage,
              onPressed: () {
                _sendAudio();
              },
            ),
          ],
        ),
      ],
    );
  }

  void _sendText() {
    if (_controller.text.isNotEmpty) {
      _updateDB(_controller.text);
      _controller.text = '';
    }
  }

  Future<DocumentReference> _updateDB(String message) async {
    final createdOn = DateTime.now().millisecondsSinceEpoch;

    DocumentReference docRef =
        await Firestore.instance.collection(messagesCollection).add({
      'uid': widget.isImam ? widget.topic['uid'] : widget.user.uid,
      'createdOn': createdOn,
      'topicId': widget.topic.documentID,
      'sender': widget.isImam ? 'i' : 'q', // Imam, Questioner
      'text': message,
      'senderName': _senderName,
    });

    widget.topic.reference.setData({
      'modifiedOn': createdOn,
    }, merge: true);

    if (widget.isImam) {
      if (widget.topic['imamUid'] == null) {
        widget.topic.reference.setData({
          'imamUid': widget.user.uid,
          'imamFcmToken': widget.fcmToken,
          'imamViewedOn': createdOn,
          'isAnswered': true,
        }, merge: true);
      }
    }

    return docRef;
  }

  void _startRecording() async {
    _audioPath =
        await _recorder.startRecorder(null, numChannels: 1, sampleRate: 8000);
    _soundRecordingSubscription = _recorder.onRecorderStateChanged.listen((e) {
      if (e != null) {
        DateTime date =
            DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt());
        setState(() {
          _recordingTime = DateFormat('mm:ss').format(date);
        });
      }
    });
    _dBLevelSubscription = _recorder.onRecorderDbPeakChanged.listen((level) {
      setState(() {
        _dBLevel = level;
      });
    });
    setState(() {
      _composerIndex = 1;
    });
  }

  void _stopRecording() async {
    await _recorder.stopRecorder();
    _soundRecordingSubscription.cancel();
    _dBLevelSubscription.cancel();
    setState(() {
      _composerIndex = 0;
    });
  }

  void _cancelRecording() async {
    _stopRecording();
    _recordingTime = _initial_recording_time;
    File(_audioPath).delete();
  }

  void _sendAudio() async {
    _stopRecording();

    DocumentReference docRef = await _updateDB(
        AppLocalizations.of(context).audioMessage + ' - ' + _recordingTime);

    final StorageReference ref = FirebaseStorage.instance
        .ref()
        .child(audioFolder)
        .child(docRef.documentID);
    final StorageUploadTask task = ref.putFile(File(_audioPath));
    final StorageTaskSnapshot snapshot = await task.onComplete;
    final String url = await snapshot.ref.getDownloadURL();

    docRef.setData({
      'audioUrl': url,
      'duration': _recordingTime,
    }, merge: true);

    _recordingTime = _initial_recording_time;
    File(_audioPath).delete();
  }
}
