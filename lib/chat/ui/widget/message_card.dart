import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:askimam/chat/domain/model/message.dart';
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

  const MessageCard(this.message, this.authState);

  bool get isImam => message.author != null;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: isImam
          ? const EdgeInsets.only(right: _margin)
          : const EdgeInsets.only(left: _margin),
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
              if (isImam) ...[
                Text(
                  message.author!,
                  style: const TextStyle(
                    color: primaryDarkColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
              ],
              AutoDirection(
                text: message.text,
                child: SelectableLinkify(
                  text: message.text,
                  onOpen: (link) async {
                    if (await canLaunch(link.url)) {
                      await launch(link.url);
                    }
                  },
                ),
              ),
              const SizedBox(height: 15),
              Row(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
