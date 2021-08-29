part of 'bottom_navigation_bloc.dart';

abstract class BottomNavigationEvent extends Equatable {
  const BottomNavigationEvent();

  @override
  List<Object> get props => [];
}

class LoadHome extends BottomNavigationEvent {
  @override
  List<Object> get props => [];
}

class LoadFavorite extends BottomNavigationEvent {
  @override
  List<Object> get props => [];
}
