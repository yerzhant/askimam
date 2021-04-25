import 'package:askimam/home/chats/bloc/my_chats_bloc.dart';
import 'package:askimam/home/chats/bloc/public_chats_bloc.dart';
import 'package:askimam/home/chats/bloc/unanswered_chats_bloc.dart';
import 'package:askimam/home/chats/ui/widget/my_chats_widget.dart';
import 'package:askimam/home/chats/ui/widget/public_chats_widget.dart';
import 'package:askimam/home/favorites/bloc/favorite_bloc.dart';
import 'package:askimam/home/favorites/ui/widget/favorites_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  final PublicChatsBloc publicChatsBloc;
  final MyChatsBloc myChatsBloc;
  final UnansweredChatsBloc unansweredChatsBloc;
  final FavoriteBloc favoriteBloc;

  const HomePage({
    Key? key,
    required this.publicChatsBloc,
    required this.myChatsBloc,
    required this.unansweredChatsBloc,
    required this.favoriteBloc,
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
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: widget.publicChatsBloc),
          BlocProvider.value(value: widget.myChatsBloc),
          BlocProvider.value(value: widget.unansweredChatsBloc),
          BlocProvider.value(value: widget.favoriteBloc),
        ],
        child: PageView(
          controller: _pageController,
          children: [
            const PublicChatsWidget(),
            const MyChatsWidget(),
            const FavoritesWidget(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getIndex(),
        onTap: (index) => _pageController.animateToPage(
          index,
          curve: Curves.ease,
          duration: const Duration(milliseconds: 300),
        ),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'Публичные',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'Мои',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'Избранные',
          ),
        ],
      ),
    );
  }

  int _getIndex() =>
      _pageController.hasClients ? _pageController.page?.round() ?? 0 : 0;
}
