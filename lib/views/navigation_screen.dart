import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import 'favorite_view.dart';
import 'home_view.dart';

final views = <Widget>[
  BlocProvider(
    create: (context) => QuoteBloc(),
    child: HomeView(),
  ),
  FavoriteQuotes(),
];

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (BuildContext context, BottomNavigationState state) {
      if (state is HomeState) {
        return View(
          currentIndex: state.index,
        );
      }
      if (state is FavoriteState) {
        return View(
          currentIndex: state.index,
        );
      }
      return Container();
    });
  }
}

class View extends StatelessWidget {
  final int currentIndex;
  View({Key? key, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Random Anime Quote')),
      // bottomNavigationBar: TabBar(
      //   tabs: <Widget>[
      //     Tab(
      //       icon: Icon(Icons.home),
      //     ),
      //     Tab(
      //       icon: Icon(Icons.favorite),
      //     ),
      //   ],
      // ),
      // body: Stack(children: [
      //   Image.asset(
      //     'images/galaxy.jpg',
      //     fit: BoxFit.fill,
      //     width: deviceSize.width,
      //     height: deviceSize.height,
      //   ),
      //   TabBarView(children: [
      //     BlocProvider(
      //       create: (context) => QuoteBloc(repository),
      //       child: HomeView(),
      //     ),
      //     FavoriteQuotes()
      //   ]),
      // ]),
      body: Stack(children: [
        Image.asset(
          'images/galaxy.jpg',
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ),
        //* A Stack that shows a single child from a list of children.
        //* The displayed child is the one with the given index. The stack is always as big as the largest child.
        IndexedStack(index: currentIndex, children: views)
      ]),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.pink.shade300,
        unselectedItemColor: Colors.grey[500],
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        onTap: (index) {
          if (index == 0) {
            return BlocProvider.of<BottomNavigationBloc>(context)
                .add(LoadHome());
          }

          if (index == 1) {
            return BlocProvider.of<BottomNavigationBloc>(context)
                .add(LoadFavorite());
          }

          return BlocProvider.of<BottomNavigationBloc>(context).add(LoadHome());
        },
        items: [
          _buildTabBarItem(icon: Icon(Icons.home), label: 'Home'),
          _buildTabBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
        ],
      ),
    );
  }
}

_buildTabBarItem({required final Widget icon, required final String label}) {
  return BottomNavigationBarItem(
    icon: icon,
    title: Text(
      label,
      style: TextStyle(fontSize: 14.0),
      textAlign: TextAlign.center,
    ),
  );
}
