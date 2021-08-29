import 'package:flutter_bloc/flutter_bloc.dart';

//* Observe all blocs
//* This is used to print whenever there's a transition between states and gives the details
class SimpleBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}
