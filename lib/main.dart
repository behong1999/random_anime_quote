import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';
import 'simple_bloc_observer.dart';
import 'views/navigation_screen.dart';

void main() {
  //* Observe all blocs which is used to print whenever there's a transition between states and gives the details
  Bloc.observer = SimpleBlocObserver();
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      //* Hide the Debug Tag
      debugShowCheckedModeBanner: false,
      home: BlocProvider<BottomNavigationBloc>(
        create: (context) => BottomNavigationBloc(),
        child: NavigationScreen(),
      ),
    );
  }
}
