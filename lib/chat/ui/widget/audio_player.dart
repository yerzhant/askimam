import 'dart:async';

import 'package:askimam/common/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart';

class AudioPlayer extends StatefulWidget {
  final String url;
  final String duration;

  const AudioPlayer(this.url, this.duration, {Key? key}) : super(key: key);

  @override
  _AudioPlayer createState() => _AudioPlayer();
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
  void initState() {
    super.initState();
    _player.setSubscriptionDuration(const Duration(microseconds: 100));
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
              if (_nowPlaying != null && _nowPlaying != this) {
                _nowPlaying?.stop();
              }
              _play();
            }
          },
        ),
        Expanded(
          child: SliderTheme(
            data: const SliderThemeData(
              trackHeight: 5,
              thumbColor: secondaryColor,
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
    await _player.startPlayer(fromURI: widget.url);
    _subscription = _player.onProgress?.listen((e) {
      _position = e.position;
      setState(() {
        _duration = e.duration;
        if (_duration == _position) {
          _nowPlaying = null;
          _isPlaying = false;
          _isPaused = false;
          _position = const Duration();
        } else {
          _nowPlaying = this;
          _isPlaying = true;
        }
        final date =
            DateTime.fromMillisecondsSinceEpoch(_position.inMilliseconds);
        _currentTime = DateFormat('mm:ss').format(date);
      });
    });
  }

  Future<void> stop() async {
    await _player.stopPlayer();
    await _subscription?.cancel();
    setState(() {
      _nowPlaying = null;
      _isPlaying = false;
      _isPaused = false;
      _position = const Duration();
    });
  }
}
