import 'dart:async';

import 'package:askimam/common/connection.dart';
import 'package:askimam/common/extention/date_extentions.dart';
import 'package:askimam/common/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';

class AudioPlayer extends StatefulWidget {
  final String fileName;
  final String duration;

  const AudioPlayer(this.fileName, this.duration, {Key? key}) : super(key: key);

  @override
  State createState() => _AudioPlayer();
}

_AudioPlayer? _nowPlaying;

class _AudioPlayer extends State<AudioPlayer> {
  final _player = FlutterSoundPlayer();

  StreamSubscription? _subscription;

  var _isPlaying = false;
  var _isPaused = false;
  var _position = const Duration();
  var _duration = const Duration();
  var _currentTime = '';

  @override
  void dispose() {
    _subscription?.cancel();
    _player.closePlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(
            _isPlaying && !_isPaused ? Icons.pause : Icons.play_arrow,
            color: primaryColor,
          ),
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
              _play();
            }
          },
        ),
        Expanded(
          child: SliderTheme(
            data: const SliderThemeData(
              trackHeight: 5,
              thumbColor: primaryColor,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
            ),
            child: Slider(
              value: _position.inMilliseconds.toDouble(),
              max: _duration.inMilliseconds.toDouble(),
              onChanged: (double value) {
                if (_isPlaying) {
                  _player.seekToPlayer(Duration(milliseconds: value.toInt()));
                }
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15, left: 5),
          child: Text(_isPlaying ? _currentTime : widget.duration),
        ),
      ],
    );
  }

  Future<void> _play() async {
    await _subscription?.cancel();
    await _nowPlaying?._stop();

    if (!_player.isOpen()) {
      await _player.openPlayer();
      await _player.setSubscriptionDuration(const Duration(milliseconds: 20));
    }

    await _player.startPlayer(
      fromURI: '$audioUrl/${widget.fileName}',
      whenFinished: () async => _stop(),
    );

    _nowPlaying = this;
    _isPlaying = true;

    _subscription = _player.onProgress?.listen((e) {
      _position = e.position;
      _duration = e.duration;

      setState(() {
        _currentTime = _position.format();
      });
    });
  }

  Future<void> _stop() async {
    await _player.stopPlayer();
    await _subscription?.cancel();
    await _player.closePlayer();

    setState(() {
      _nowPlaying = null;
      _isPlaying = false;
      _isPaused = false;
      _position = const Duration();
    });
  }
}
