import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

enum HomePopupMenuAction { logout, azanKz, shareApp }

class HomePopupMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return PopupMenuButton(
        itemBuilder: (_) => state.maybeWhen(
          authenticated: (_) => [
            _azanKz(),
            // _shareApp(),
            _logout(),
          ],
          orElse: () => [
            _azanKz(),
            // _shareApp(),
          ],
        ),
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
    });
  }

  PopupMenuItem<HomePopupMenuAction> _azanKz() {
    return const PopupMenuItem(
      value: HomePopupMenuAction.azanKz,
      child: Text('Azan.kz'),
    );
  }

  PopupMenuItem<HomePopupMenuAction> _shareApp() {
    return const PopupMenuItem(
      value: HomePopupMenuAction.shareApp,
      child: Text('Поделится'),
    );
  }

  PopupMenuItem<HomePopupMenuAction> _logout() {
    return const PopupMenuItem(
      value: HomePopupMenuAction.logout,
      child: Text('Выйти'),
    );
  }
}
