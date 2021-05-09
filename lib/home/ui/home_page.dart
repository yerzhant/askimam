import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/home/chats/bloc/my_chats_bloc.dart';
import 'package:askimam/home/chats/bloc/public_chats_bloc.dart';
import 'package:askimam/home/chats/bloc/unanswered_chats_bloc.dart';
import 'package:askimam/home/chats/ui/widget/my_chats_widget.dart';
import 'package:askimam/home/chats/ui/widget/public_chats_widget.dart';
import 'package:askimam/home/chats/ui/widget/unanswered_chats_widget.dart';
import 'package:askimam/home/favorites/bloc/favorite_bloc.dart';
import 'package:askimam/home/favorites/ui/widget/favorites_widget.dart';
import 'package:askimam/home/ui/widget/home_popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  final AuthBloc authBloc;
  final MyChatsBloc myChatsBloc;
  final FavoriteBloc favoriteBloc;
  final PublicChatsBloc publicChatsBloc;
  final UnansweredChatsBloc unansweredChatsBloc;

  HomePage({
    Key? key,
    required this.authBloc,
    required this.myChatsBloc,
    required this.favoriteBloc,
    required this.publicChatsBloc,
    required this.unansweredChatsBloc,
  }) : super(key: key) {
    _initialReloading();
  }

  void _initialReloading() {
    authBloc.state.maybeWhen(
      authenticated: (auth) {
        if (auth.userType == UserType.Imam) {
          unansweredChatsBloc.add(const UnansweredChatsEvent.reload());
        }
        myChatsBloc.add(const MyChatsEvent.reload());
        publicChatsBloc.add(const PublicChatsEvent.reload());
        favoriteBloc.add(const FavoriteEvent.refresh());
      },
      orElse: () => publicChatsBloc.add(const PublicChatsEvent.reload()),
    );
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: widget.authBloc),
        BlocProvider.value(value: widget.myChatsBloc),
        BlocProvider.value(value: widget.favoriteBloc),
        BlocProvider.value(value: widget.publicChatsBloc),
        BlocProvider.value(value: widget.unansweredChatsBloc),
      ],
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, __) => widget._initialReloading(),
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Вопрос имаму'),
              actions: [HomePopupMenu()],
            ),
            body: PageView(
              controller: _pageController,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              onPageChanged: (_) {
                setState(() {});
              },
              children: state.maybeWhen(
                authenticated: (auth) => [
                  if (auth.userType == UserType.Imam)
                    const UnansweredChatsWidget(),
                  MyChatsWidget(widget.authBloc),
                  const PublicChatsWidget(),
                  const FavoritesWidget(),
                ],
                orElse: () => [
                  const PublicChatsWidget(),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.maybeWhen(
                authenticated: (_) => _getIndex(),
                orElse: () => 0,
              ),
              onTap: (index) => _onBottomNavTap(state, index),
              items: _items(state),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => state.maybeWhen(
                authenticated: (_) => Modular.to.pushNamed('/new-question'),
                orElse: () => Modular.to.pushNamed('/auth/login'),
              ),
              mini: true,
              child: const Icon(Icons.add_rounded),
            ),
            floatingActionButtonLocation: state.maybeWhen(
              authenticated: (auth) {
                if (auth.userType == UserType.Imam) {
                  return FloatingActionButtonLocation.centerDocked;
                } else {
                  return FloatingActionButtonLocation.endFloat;
                }
              },
              orElse: () => FloatingActionButtonLocation.endFloat,
            ),
          );
        },
      ),
    );
  }

  void _onBottomNavTap(AuthState state, int index) {
    state.maybeWhen(
      authenticated: (auth) {
        final ix = auth.userType == UserType.Imam ? index : index + 1;
        switch (HomePageView.values[ix]) {
          case HomePageView.New:
            widget.unansweredChatsBloc.add(const UnansweredChatsEvent.show());
            break;
          case HomePageView.My:
            widget.myChatsBloc.add(const MyChatsEvent.show());
            break;
          case HomePageView.Public:
            widget.publicChatsBloc.add(const PublicChatsEvent.show());
            break;
          case HomePageView.Favorites:
            widget.favoriteBloc.add(const FavoriteEvent.show());
            break;
        }

        _goToPage(index);
      },
      orElse: () => Modular.to.pushNamed('/auth/login'),
    );
  }

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      curve: Curves.ease,
      duration: const Duration(milliseconds: 300),
    );
  }

  List<BottomNavigationBarItem> _items(AuthState state) => state.maybeWhen(
        authenticated: (auth) => [
          if (auth.userType == UserType.Imam) _newItem(),
          _myItem(),
          _publicItem(),
          _favoritesItem(),
        ],
        orElse: () => [
          _publicItem(),
          _myItem(),
          _favoritesItem(),
        ],
      );

  BottomNavigationBarItem _favoritesItem() {
    return const BottomNavigationBarItem(
      icon: Icon(Icons.bookmark),
      label: 'Избранные',
    );
  }

  BottomNavigationBarItem _myItem() {
    return const BottomNavigationBarItem(
      icon: Icon(Icons.question_answer),
      label: 'Мои',
    );
  }

  BottomNavigationBarItem _publicItem() {
    return const BottomNavigationBarItem(
      icon: Icon(Icons.public),
      label: 'Публичные',
    );
  }

  BottomNavigationBarItem _newItem() {
    return const BottomNavigationBarItem(
      icon: Icon(Icons.new_releases),
      label: 'Новые',
    );
  }

  int _getIndex() =>
      _pageController.hasClients ? _pageController.page?.round() ?? 0 : 0;
}

enum HomePageView { New, My, Public, Favorites }
