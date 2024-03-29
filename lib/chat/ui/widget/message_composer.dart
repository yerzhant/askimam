import 'dart:async';
import 'dart:io';

import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/chat/bloc/chat_bloc.dart';
import 'package:askimam/common/extention/date_extentions.dart';
import 'package:askimam/common/ui/theme.dart';
import 'package:askimam/common/ui/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class MessageComposer extends StatefulWidget {
  final Authentication auth;
  final FlutterSoundRecorder recorder;

  const MessageComposer(
    this.auth,
    this.recorder, {
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _MessageComposerState();
}

class _MessageComposerState extends State<MessageComposer> {
  var _stackIndex = 0;

  final _controller = TextEditingController();

  StreamSubscription<RecordingDisposition>? _recorderSubscription;
  var _dbLevel = 0.0;
  var _recorderTime = Duration.zero;
  String? _audioFilePath;

  @override
  void initState() {
    super.initState();
    widget.recorder.openRecorder();
  }

  @override
  void dispose() {
    _controller.dispose();
    _recorderSubscription?.cancel();
    widget.recorder.closeRecorder();
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
          icon: const Icon(Icons.send_rounded, color: primaryColor),
          onPressed: () {
            final text = _controller.text.trim();

            if (text.isNotEmpty) {
              context.read<ChatBloc>().add(ChatEventAddText(text));
              _controller.text = '';
            }
          },
        ),
        if (widget.auth.userType == UserType.Imam)
          IconButton(
            onPressed: () => _startRecording(context),
            icon: const Icon(Icons.mic_rounded, color: primaryColor),
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
              backgroundColor: primaryColor,
            ),
          ),
        ),
        Text(_recorderTime.format()),
        IconButton(
          onPressed: _cancelRecording,
          icon: const Icon(Icons.cancel_rounded, color: warningColor),
        ),
        IconButton(
          onPressed: () => _sendAudio(context),
          icon: const Icon(Icons.send_rounded, color: primaryColor),
        ),
      ],
    );
  }

  Future<void> _startRecording(BuildContext context) async {
    if (!await Permission.microphone.request().isGranted) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Доступ к микрофону запрещён.')));

      return;
    }

    final fileName = '${const Uuid().v4()}.mp4';
    await widget.recorder.startRecorder(toFile: fileName, codec: Codec.aacMP4);

    _recorderSubscription = widget.recorder.onProgress?.listen((event) {
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
    _audioFilePath = await widget.recorder.stopRecorder();

    setState(() {
      _stackIndex = 0;
    });
  }

  Future<void> _cancelRecording() async {
    await _stopRecording();
    await File(_audioFilePath!).delete();
  }

  void _sendAudio(BuildContext context) {
    _stopRecording().then((_) {
      final file = File(_audioFilePath!);
      final duration = _recorderTime.format();
      context.read<ChatBloc>().add(ChatEventAddAudio(file, duration));
    });
  }
}
