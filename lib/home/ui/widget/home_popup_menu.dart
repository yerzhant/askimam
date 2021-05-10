import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';

enum HomePopupMenuAction { login, logout, azanKz, shareApp, imamRatings }

class HomePopupMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return PopupMenuButton(
        itemBuilder: (_) => state.maybeWhen(
          authenticated: (_) => [
            _imamRatings(),
            _azanKz(),
            // _shareApp(),
            _logout(),
          ],
          orElse: () => [
            _imamRatings(),
            _azanKz(),
            _login(),
            // _shareApp(),
          ],
        ),
        onSelected: (action) {
          switch (action) {
            case HomePopupMenuAction.azanKz:
              launch('https://azan.kz');
              break;

            case HomePopupMenuAction.login:
              Modular.to.pushNamed('/auth/login');
              break;

            case HomePopupMenuAction.imamRatings:
              Modular.to.pushNamed('/imam-ratings');
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

  PopupMenuItem<HomePopupMenuAction> _login() {
    return const PopupMenuItem(
      value: HomePopupMenuAction.login,
      child: Text('Войти'),
    );
  }

  PopupMenuItem<HomePopupMenuAction> _logout() {
    return const PopupMenuItem(
      value: HomePopupMenuAction.logout,
      child: Text('Выйти'),
    );
  }

  PopupMenuItem<HomePopupMenuAction> _imamRatings() {
    return const PopupMenuItem(
      value: HomePopupMenuAction.imamRatings,
      child: Text('Рейтинг устазов'),
    );
  }
}
