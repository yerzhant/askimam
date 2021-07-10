import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePopupMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        itemBuilder: (_) => state.maybeWhen(
          authenticated: (_) => [
            _imamRatings(),
            _azanKz(),
            if (!kIsWeb) _webVersion(),
            if (kIsWeb) ...[
              _iosVersion(),
              _androidVersion(),
            ],
            _logout(),
          ],
          orElse: () => [
            _imamRatings(),
            _azanKz(),
            if (!kIsWeb) _webVersion(),
            if (kIsWeb) ...[
              _iosVersion(),
              _androidVersion(),
            ],
            _login(),
          ],
        ),
        onSelected: (action) {
          switch (action) {
            case _HomePopupMenuAction.azanKz:
              launch('https://azan.kz');
              break;

            case _HomePopupMenuAction.webVersion:
              launch('https://askimam.azan.kz');
              break;

            case _HomePopupMenuAction.iosVersion:
              launch(
                  'https://apps.apple.com/us/app/%D0%B2%D0%BE%D0%BF%D1%80%D0%BE%D1%81-%D0%B8%D0%BC%D0%B0%D0%BC%D1%83-azan-kz/id1481811875');
              break;

            case _HomePopupMenuAction.androidVersion:
              launch(
                  'https://play.google.com/store/apps/details?id=kz.azan.askimam');
              break;

            case _HomePopupMenuAction.login:
              Modular.to.pushNamed('/auth/login');
              break;

            case _HomePopupMenuAction.imamRatings:
              Modular.to.pushNamed('/imam-ratings');
              break;

            case _HomePopupMenuAction.logout:
              context.read<AuthBloc>().add(const AuthEvent.logout());
              break;
          }
        },
      );
    });
  }

  PopupMenuItem<_HomePopupMenuAction> _azanKz() {
    return const PopupMenuItem(
      value: _HomePopupMenuAction.azanKz,
      child: Text('Azan.kz'),
    );
  }

  PopupMenuItem<_HomePopupMenuAction> _webVersion() {
    return const PopupMenuItem(
      value: _HomePopupMenuAction.webVersion,
      child: Text('Веб версия'),
    );
  }

  PopupMenuItem<_HomePopupMenuAction> _iosVersion() {
    return const PopupMenuItem(
      value: _HomePopupMenuAction.webVersion,
      child: Text('iOS версия'),
    );
  }

  PopupMenuItem<_HomePopupMenuAction> _androidVersion() {
    return const PopupMenuItem(
      value: _HomePopupMenuAction.webVersion,
      child: Text('Android версия'),
    );
  }

  PopupMenuItem<_HomePopupMenuAction> _login() {
    return const PopupMenuItem(
      value: _HomePopupMenuAction.login,
      child: Text('Войти'),
    );
  }

  PopupMenuItem<_HomePopupMenuAction> _logout() {
    return const PopupMenuItem(
      value: _HomePopupMenuAction.logout,
      child: Text('Выйти'),
    );
  }

  PopupMenuItem<_HomePopupMenuAction> _imamRatings() {
    return const PopupMenuItem(
      value: _HomePopupMenuAction.imamRatings,
      child: Text('Рейтинг устазов'),
    );
  }
}

enum _HomePopupMenuAction {
  login,
  logout,
  azanKz,
  webVersion,
  iosVersion,
  androidVersion,
  imamRatings,
}
