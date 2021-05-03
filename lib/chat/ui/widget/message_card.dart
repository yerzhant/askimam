import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/chat/domain/model/message.dart';
import 'package:askimam/chat/ui/widget/audio_player.dart';
import 'package:askimam/common/extention/date_extentions.dart';
import 'package:askimam/common/ui/theme.dart';
import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

const _margin = 50.0;

class MessageCard extends StatelessWidget {
  final Message message;
  final AuthState authState;
  final bool isItMine;

  const MessageCard(
    this.message,
    this.authState, {
    this.isItMine = false,
  });

  bool get isImam => message.author != null;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: authState.maybeWhen(
        authenticated: (auth) {
          if (auth.userType == UserType.Imam && isImam) {
            return primaryLightColor;
          }
          if (isItMine && !isImam) return primaryLightColor;
        },
        orElse: () => null,
      ),
      margin: authState.maybeWhen(
        authenticated: (auth) => _margins(
          auth.userType == UserType.Imam && !isImam ||
              auth.userType == UserType.Inquirer && isImam,
        ),
        orElse: () => _margins(isImam),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          textTheme: Theme.of(context).textTheme.copyWith(
                bodyText2: const TextStyle(
                  color: Colors.black,
                  height: 1.6,
                ),
              ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isImam) ..._imamsName,
              if (message.type == MessageType.Text)
                _text
              else
                AudioPlayer(message.audio!, message.duration!),
              const SizedBox(height: 15),
              _dates(context),
            ],
          ),
        ),
      ),
    );
  }

  EdgeInsets _margins(bool isRight) => isRight
      ? const EdgeInsets.only(right: _margin)
      : const EdgeInsets.only(left: _margin);

  Row _dates(BuildContext context) => Row(
        children: [
          Text(
            message.createdAt.format(),
            style: Theme.of(context).textTheme.caption,
          ),
          if (message.updatedAt != null)
            Text(
              '| ${message.updatedAt!.format()}',
              style: Theme.of(context).textTheme.caption,
            ),
        ],
      );

  List<Widget> get _imamsName => [
        Text(
          message.author!,
          style: const TextStyle(
            color: primaryDarkColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
      ];

  AutoDirection get _text => AutoDirection(
        text: message.text,
        child: SizedBox(
          width: double.infinity,
          child: SelectableLinkify(
            text: message.text,
            linkStyle: const TextStyle(color: primaryDarkColor),
            onOpen: (link) async {
              if (await canLaunch(link.url)) {
                await launch(link.url);
              }
            },
          ),
        ),
      );
}
