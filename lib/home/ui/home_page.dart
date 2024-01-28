import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/common/ui/theme.dart';
import 'package:askimam/home/chats/bloc/my_chats_bloc.dart';
import 'package:askimam/home/chats/bloc/public_chats_bloc.dart';
import 'package:askimam/home/chats/bloc/unanswered_chats_bloc.dart';
import 'package:askimam/home/chats/ui/widget/my_chats_widget.dart';
import 'package:askimam/home/chats/ui/widget/public_chats_widget.dart';
import 'package:askimam/home/chats/ui/widget/unanswered_chats_widget.dart';
import 'package:askimam/home/favorites/bloc/favorite_bloc.dart';
import 'package:askimam/home/favorites/ui/widget/favorites_widget.dart';
import 'package:askimam/home/search/bloc/search_chats_bloc.dart';
import 'package:askimam/home/search/ui/widget/search_chats_widget.dart';
import 'package:askimam/home/ui/widget/home_popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  final AuthBloc authBloc;
  final MyChatsBloc myChatsBloc;
  final FavoriteBloc favoriteBloc;
  final SearchChatsBloc searchChatsBloc;
  final PublicChatsBloc publicChatsBloc;
  final UnansweredChatsBloc unansweredChatsBloc;

  HomePage({
    Key? key,
    required this.authBloc,
    required this.myChatsBloc,
    required this.favoriteBloc,
    required this.searchChatsBloc,
    required this.publicChatsBloc,
    required this.unansweredChatsBloc,
  }) : super(key: key) {
    _initialReloading();
  }

  void _initialReloading() {
    switch (authBloc.state) {
      case AuthStateAuthenticated(authentication: final auth):
        if (auth.userType == UserType.Imam) {
          unansweredChatsBloc.add(const UnansweredChatsEventReload());
        }
        myChatsBloc.add(const MyChatsEventReload());
        publicChatsBloc.add(const PublicChatsEventReload());
        favoriteBloc.add(const FavoriteEventRefresh());

      default:
        publicChatsBloc.add(const PublicChatsEventReload());
    }
  }

  @override
  State createState() => _HomePageState();
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
        BlocProvider.value(value: widget.searchChatsBloc),
        BlocProvider.value(value: widget.publicChatsBloc),
        BlocProvider.value(value: widget.unansweredChatsBloc),
      ],
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, __) => widget._initialReloading(),
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Вопрос имаму'),
              actions: const [HomePopupMenu()],
            ),
            body: PageView(
              controller: _pageController,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              onPageChanged: (_) {
                setState(() {});
              },
              children: switch (state) {
                AuthStateAuthenticated(authentication: final auth) => [
                    if (auth.userType == UserType.Imam)
                      const UnansweredChatsWidget(),
                    MyChatsWidget(widget.authBloc),
                    const PublicChatsWidget(),
                    const FavoritesWidget(),
                    const SearchChatsWidget(),
                  ],
                _ => [
                    const PublicChatsWidget(),
                    Container(),
                    Container(),
                    const SearchChatsWidget(),
                  ],
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _getIndex(),
              onTap: (index) => _onBottomNavTap(state, index),
              items: _items(state),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => switch (state) {
                AuthStateAuthenticated() =>
                  Modular.to.pushNamed('/new-question'),
                _ => Modular.to.pushNamed('/auth/login'),
              },
              mini: true,
              child: const Icon(
                color: primaryColor,
                Icons.question_mark_rounded,
              ),
            ),
          );
        },
      ),
    );
  }

  void _onBottomNavTap(AuthState state, int index) {
    switch (state) {
      case AuthStateAuthenticated(authentication: final auth):
        final ix = auth.userType == UserType.Imam ? index : index + 1;

        switch (HomePageView.values[ix]) {
          case HomePageView.newOnes:
            widget.unansweredChatsBloc.add(const UnansweredChatsEventShow());

          case HomePageView.my:
            widget.myChatsBloc.add(const MyChatsEventShow());
          case HomePageView.public:
            widget.publicChatsBloc.add(const PublicChatsEventShow());
          case HomePageView.favorites:
            widget.favoriteBloc.add(const FavoriteEventShow());
          case HomePageView.search:
            break;
        }

        _goToPage(index);

      default:
        if (index == 0 || index == 3) {
          _goToPage(index);
        } else {
          Modular.to.pushNamed('/auth/login');
        }
    }
  }

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      curve: Curves.ease,
      duration: const Duration(milliseconds: 300),
    );
  }

  List<BottomNavigationBarItem> _items(AuthState state) => switch (state) {
        AuthStateAuthenticated(authentication: final auth) => [
            if (auth.userType == UserType.Imam) _newItem(),
            _myItem(),
            _publicItem(),
            _favoritesItem(),
            _searchItem(),
          ],
        _ => [
            _publicItem(),
            _myItem(),
            _favoritesItem(),
            _searchItem(),
          ],
      };

  BottomNavigationBarItem _searchItem() {
    return const BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Поиск',
    );
  }

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

enum HomePageView { newOnes, my, public, favorites, search }
