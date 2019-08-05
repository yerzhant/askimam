import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

import 'package:askimam/localization.dart';

class AudioPlayer extends StatefulWidget {
  final Map<String, dynamic> data;

  const AudioPlayer({Key key, this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AudioPlayer();
}

_AudioPlayer currentlyPlaying;

class _AudioPlayer extends State<AudioPlayer> {
  final _player = FlutterSound();
  StreamSubscription _subscription;
  bool _isPlaying = false;
  bool _isPaused = false;
  double _position = 0;
  double _duration = 0;

  @override
  void initState() {
    super.initState();
    _player.setSubscriptionDuration(.1);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(
            _isPlaying && !_isPaused ? Icons.pause : Icons.play_arrow,
            color: Theme.of(context).primaryColor,
          ),
          tooltip: AppLocalizations.of(context).sendMessage,
          onPressed: () {
            if (_isPlaying) {
              if (_isPaused) {
                _isPaused = false;
                _player.resumePlayer();
              } else {
                _isPaused = true;
                _player.pausePlayer();
              }
            } else {
              if (currentlyPlaying != null && currentlyPlaying != this) {
                currentlyPlaying.stop();
              }
              _play();
            }
          },
        ),
        Expanded(
          child: SliderTheme(
            data: SliderThemeData(
              trackHeight: 5,
              thumbColor: Colors.orange,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
            ),
            child: Slider(
              value: _position,
              max: _duration,
              onChanged: (double value) {
                if (_isPlaying) {
                  _player.seekToPlayer(value.toInt());
                }
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15, left: 5),
          child: Text(widget.data['duration']),
        ),
      ],
    );
  }

  void _play() async {
    await _player.startPlayer(widget.data['audioUrl']);
    _subscription = _player.onPlayerStateChanged.listen((e) {
      if (e != null) {
        setState(() {
          _duration = e.duration;
          _position = e.currentPosition;
          if (_duration == _position) {
            currentlyPlaying = null;
            _isPlaying = false;
            _isPaused = false;
            _position = 0;
          } else {
            currentlyPlaying = this;
            _isPlaying = true;
          }
        });
      }
    });
  }

  void stop() async {
    await _player.stopPlayer();
    _subscription.cancel();
    setState(() {
      currentlyPlaying = null;
      _isPlaying = false;
      _isPaused = false;
      _position = 0;
    });
  }
}
