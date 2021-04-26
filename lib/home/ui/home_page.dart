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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  final PublicChatsBloc publicChatsBloc;
  final MyChatsBloc myChatsBloc;
  final UnansweredChatsBloc unansweredChatsBloc;
  final FavoriteBloc favoriteBloc;
  final AuthBloc authBloc;

  const HomePage({
    Key? key,
    required this.publicChatsBloc,
    required this.myChatsBloc,
    required this.unansweredChatsBloc,
    required this.favoriteBloc,
    required this.authBloc,
  }) : super(key: key);

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
        BlocProvider.value(value: widget.publicChatsBloc),
        BlocProvider.value(value: widget.myChatsBloc),
        BlocProvider.value(value: widget.unansweredChatsBloc),
        BlocProvider.value(value: widget.favoriteBloc),
        BlocProvider.value(value: widget.authBloc),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Scaffold(
            body: PageView(
              controller: _pageController,
              children: state.maybeWhen(
                authenticated: (auth) => [
                  if (auth.userType == UserType.Imam)
                    const UnansweredChatsWidget(),
                  const MyChatsWidget(),
                  const PublicChatsWidget(),
                  const FavoritesWidget(),
                ],
                unauthenticated: () => [
                  const PublicChatsWidget(),
                  // const MyChatsWidget(),
                  // const FavoritesWidget(),
                ],
                orElse: () => [],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _getIndex(),
              onTap: (index) {
                state.maybeWhen(
                  authenticated: (auth) {
                    final ix = auth.userType == UserType.Imam ? index : ++index;
                    switch (HomePageView.values[ix]) {
                      case HomePageView.New:
                        widget.unansweredChatsBloc
                            .add(const UnansweredChatsEvent.show());
                        break;
                      case HomePageView.My:
                        widget.myChatsBloc.add(const MyChatsEvent.show());
                        break;
                      case HomePageView.Public:
                        widget.publicChatsBloc
                            .add(const PublicChatsEvent.show());
                        break;
                      case HomePageView.Favorites:
                        widget.favoriteBloc.add(const FavoriteEvent.show());
                        break;
                    }

                    _pageController.animateToPage(
                      index,
                      curve: Curves.ease,
                      duration: const Duration(milliseconds: 300),
                    );
                  },
                  orElse: () {},
                );
              },
              items: state.maybeWhen(
                authenticated: (auth) => [
                  if (auth.userType == UserType.Imam) _newItem(),
                  _myItem(),
                  _publicItem(),
                  _favoritesItem(),
                ],
                unauthenticated: () => [
                  _publicItem(),
                  _myItem(),
                  _favoritesItem(),
                ],
                orElse: () => [],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => state.maybeWhen(
                authenticated: (_) => Modular.to.navigate('/new-question'),
                orElse: () => Modular.to.navigate('/auth/login'),
              ),
            ),
          );
        },
      ),
    );
  }

  BottomNavigationBarItem _favoritesItem() {
    return const BottomNavigationBarItem(
      icon: Icon(Icons.public),
      label: 'Избранные',
    );
  }

  BottomNavigationBarItem _myItem() {
    return const BottomNavigationBarItem(
      icon: Icon(Icons.public),
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
