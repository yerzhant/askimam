import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/chat/domain/model/message.dart';
import 'package:askimam/chat/ui/widget/audio_player.dart';
import 'package:askimam/common/extention/date_extentions.dart';
import 'package:askimam/common/ui/theme.dart';
import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher_string.dart';

const _margin = 50.0;

class MessageCard extends StatelessWidget {
  final Message message;
  final AuthState authState;
  final bool isItMine;

  const MessageCard(
    this.message,
    this.authState, {
    super.key,
    this.isItMine = false,
  });

  bool get isImam => message.author != null;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: switch (authState) {
        AuthStateAuthenticated(authentication: final auth) => () {
            if (auth.userType == UserType.Imam && isImam) {
              return primaryLightColor;
            }

            if (isItMine && !isImam) return primaryLightColor;

            return null;
          }.call(),
        _ => null,
      },
      margin: switch (authState) {
        AuthStateAuthenticated(authentication: final auth) => _margins(
            auth.userType == UserType.Imam && !isImam ||
                auth.userType == UserType.Inquirer && isImam,
          ),
        _ => _margins(isImam),
      },
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
    );
  }

  EdgeInsets _margins(bool isRight) => isRight
      ? const EdgeInsets.only(right: _margin)
      : const EdgeInsets.only(left: _margin);

  Row _dates(BuildContext context) => Row(
        children: [
          Text(
            message.createdAt.format(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          if (message.updatedAt != null)
            Text(
              ' | ${message.updatedAt!.format()}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
        ],
      );

  List<Widget> get _imamsName => [
        Text(
          message.author!,
          style: const TextStyle(
            color: primaryColor,
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
            style: const TextStyle(height: 1.6),
            linkStyle: const TextStyle(color: primaryColor),
            onOpen: (link) async {
              if (await canLaunchUrlString(link.url)) {
                await launchUrlString(link.url);
              }
            },
          ),
        ),
      );
}
