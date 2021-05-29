import 'dart:async';
import 'dart:io';

import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/chat/bloc/chat_bloc.dart';
import 'package:askimam/common/ui/theme.dart';
import 'package:askimam/common/ui/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class MessageComposer extends StatefulWidget {
  final Authentication auth;

  const MessageComposer(
    this.auth, {
    Key? key,
  }) : super(key: key);

  @override
  _MessageComposerState createState() => _MessageComposerState();
}

class _MessageComposerState extends State<MessageComposer> {
  var _stackIndex = 0;

  final _controller = TextEditingController();

  final _recorder = FlutterSoundRecorder();
  StreamSubscription<RecordingDisposition>? _recorderSubscription;
  var _dbLevel = 0.0;
  var _recorderTime = Duration.zero;
  String? _audioFilePath;

  @override
  void initState() {
    super.initState();
    _recorder.openAudioSession();
  }

  @override
  void dispose() {
    _recorderSubscription?.cancel();
    _recorder.closeAudioSession();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 1),
        IndexedStack(
          index: _stackIndex,
          children: [
            _textComposer(context),
            _audioComposer(context),
          ],
        ),
      ],
    );
  }

  Row _textComposer(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Введите сообщение',
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(10),
            ),
            maxLines: null,
            style: const TextStyle(height: 1.6),
            textCapitalization: TextCapitalization.sentences,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send, color: primaryColor),
          onPressed: () {
            final text = _controller.text.trim();

            if (text.isNotEmpty) {
              context.read<ChatBloc>().add(ChatEvent.addText(text));
              _controller.text = '';
            }
          },
        ),
        if (widget.auth.userType == UserType.Imam)
          IconButton(
            onPressed: () => _startRecording(context),
            icon: const Icon(Icons.mic, color: primaryColor),
          ),
      ],
    );
  }

  Row _audioComposer(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: basePadding),
            child: LinearProgressIndicator(
              value: _dbLevel / 120,
              backgroundColor: secondaryColor,
            ),
          ),
        ),
        Text(_recorderTime.format()),
        IconButton(
          onPressed: _cancelRecording,
          icon: const Icon(Icons.cancel, color: secondaryDarkColor),
        ),
        IconButton(
          onPressed: () => _sendAudio(context),
          icon: const Icon(Icons.send, color: primaryColor),
        ),
      ],
    );
  }

  Future<void> _startRecording(BuildContext context) async {
    if (!await Permission.microphone.request().isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Доступ к микрофону запрещён.')));

      return;
    }

    final fileName = '${const Uuid().v4()}.mp3';
    await _recorder.startRecorder(toFile: fileName);

    _recorderSubscription = _recorder.onProgress?.listen((event) {
      setState(() {
        _dbLevel = event.decibels ?? 0.0;
        _recorderTime = event.duration;
      });
    });

    setState(() {
      _recorderTime = Duration.zero;
      _stackIndex = 1;
    });
  }

  Future<void> _stopRecording() async {
    await _recorderSubscription?.cancel();
    _audioFilePath = await _recorder.stopRecorder();

    setState(() {
      _stackIndex = 0;
    });
  }

  Future<void> _cancelRecording() async {
    await _stopRecording();
    await File(_audioFilePath!).delete();
  }

  Future<void> _sendAudio(BuildContext context) async {
    await _stopRecording();
    final file = File(_audioFilePath!);
    final duration = _recorderTime.format();
    context.read<ChatBloc>().add(ChatEvent.addAudio(file, duration));
  }
}

extension _Duration on Duration {
  String format() =>
      '$inMinutes:${(inSeconds % 60).toString().padLeft(2, "0")}';
}
