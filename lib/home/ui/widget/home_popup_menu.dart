import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

enum HomePopupMenuAction { logout, azanKz, shareApp }

class HomePopupMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (_) => [
        const PopupMenuItem(
          value: HomePopupMenuAction.azanKz,
          child: Text('Azan.kz'),
        ),
        const PopupMenuItem(
          value: HomePopupMenuAction.logout,
          child: Text('Поделится'),
        ),
        const PopupMenuItem(
          value: HomePopupMenuAction.shareApp,
          child: Text('Выйти'),
        ),
      ],
      onSelected: (action) {
        switch (action) {
          case HomePopupMenuAction.azanKz:
            launch('https://azan.kz');
            break;
          case HomePopupMenuAction.logout:
            context.read<AuthBloc>().add(const AuthEvent.logout());
            break;
        }
      },
    );
  }
}
